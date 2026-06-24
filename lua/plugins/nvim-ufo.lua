return {
  "kevinhwang91/nvim-ufo",

  dependencies = {
    "kevinhwang91/promise-async",
  },

  lazy = true,
  event = "VeryLazy",

  config = function()
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

    -- Comment prefix per filetype for #region detection
    local comment_prefix = {
      lua = "--",
      python = "#",
      ruby = "#",
      sh = "#",
      bash = "#",
      zsh = "#",
      yaml = "#",
      toml = "#",
      proto = "//",
      c = "//",
      cpp = "//",
      go = "//",
      typescript = "//",
      javascript = "//",
      typescriptreact = "//",
      javascriptreact = "//",
      java = "//",
      cs = "//",
      rust = "//",
    }
    local default_prefix = "//"

    -- Returns #region fold ranges for the given buffer
    local function get_region_ranges(bufnr)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local ft = vim.bo[bufnr].filetype
      local prefix = comment_prefix[ft] or default_prefix
      local region_start = "^%s*" .. vim.pesc(prefix) .. "%s*#region"
      local region_end = "^%s*" .. vim.pesc(prefix) .. "%s*#endregion"

      local ranges = {}
      local stack = {}
      for i, line in ipairs(lines) do
        if line:match(region_start) then
          table.insert(stack, i - 1) -- ufo uses 0-indexed lines
        elseif line:match(region_end) then
          local start = table.remove(stack)
          if start then
            table.insert(ranges, { startLine = start, endLine = i - 1, kind = "region" })
          end
        end
      end
      return ranges
    end

    -- Wraps a provider name and merges #region ranges on top of its results.
    -- Region ranges that don't overlap existing folds are appended.
    local function with_regions(provider_name)
      return function(bufnr)
        local promise = require("promise")
        local provider = require("ufo.provider." .. provider_name)
        local result = provider.getFolds(bufnr)
        -- Some providers (e.g. treesitter) return a plain table, not a Promise.
        -- Normalise to a Promise so we can always call :thenCall().
        local p = promise.resolve(result)
        return p:thenCall(function(ranges)
          ranges = ranges or {}
          -- Build a set of existing startLines for quick overlap check
          local existing = {}
          for _, r in ipairs(ranges) do
            existing[r.startLine] = true
          end
          for _, r in ipairs(get_region_ranges(bufnr)) do
            if not existing[r.startLine] then
              table.insert(ranges, r)
            end
          end
          return ranges
        end, function(_reason)
          -- Main provider failed; return only region ranges
          return get_region_ranges(bufnr)
        end)
      end
    end

    -- Filetypes with a working LSP that reports fold ranges
    local lsp_filetypes = {
      lua = true,
      go = true,
      typescript = true,
      javascript = true,
      typescriptreact = true,
      javascriptreact = true,
      cs = true,
      ps1 = true,
      psm1 = true,
      psd1 = true,
      proto = true,
    }

    -- #region line highlighting -----------------------------------------------
    -- NOTE: unrelated to folding; purely visual. Uses extmarks to place a
    -- sign next to the line number (like diagnostics) and recolor the line
    -- foreground to lavender on #region / #endregion lines.
    -- Highlight groups are defined in appearance.lua.

    local region_ns = vim.api.nvim_create_namespace("ufo_region_hl")

    local function highlight_regions(bufnr)
      vim.api.nvim_buf_clear_namespace(bufnr, region_ns, 0, -1)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local ft = vim.bo[bufnr].filetype
      local prefix = comment_prefix[ft] or default_prefix
      local region_start = "^%s*" .. vim.pesc(prefix) .. "%s*#region"
      local region_end = "^%s*" .. vim.pesc(prefix) .. "%s*#endregion"
      for i, line in ipairs(lines) do
        local is_start = line:match(region_start)
        local is_end = line:match(region_end)
        if is_start or is_end then
          local line_len = vim.fn.strdisplaywidth(line)
          local dashes = line_len < 79 and (" " .. string.rep("-", 79 - line_len)) or ""
          vim.api.nvim_buf_set_extmark(bufnr, region_ns, i - 1, 0, {
            sign_text = is_start and "▶" or "◀",
            sign_hl_group = "UfoRegionSign",
            number_hl_group = "UfoRegionSign",
            line_hl_group = "UfoRegionLine",
            virt_text = { { dashes, "UfoRegionVirt" } },
            virt_text_pos = "eol",
          })
        end
      end
    end

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "TextChanged", "TextChangedI" }, {
      group = vim.api.nvim_create_augroup("UfoRegionHighlight", { clear = true }),
      callback = function(ev) highlight_regions(ev.buf) end,
    })
    -- -------------------------------------------------------------------------

    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        if lsp_filetypes[filetype] then
          return with_regions("lsp")
        end
        return with_regions("treesitter")
      end,
    })
  end,
}
