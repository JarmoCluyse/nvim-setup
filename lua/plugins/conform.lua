-- NOTE: [[ Formatting ]]
-- plugin to run formatting
-- TODO: add progress!

return {
  "stevearc/conform.nvim", -- cspell:disable-line
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local function biome_or_prettier(bufnr)
      if conform.get_formatter_info("biome", bufnr).available then
        return { "biome-organize-imports", "biome" }
      end
      return { "prettier" }
    end

    conform.setup({
      formatters_by_ft = {
        cs = { "csharpier" },
        javascript = biome_or_prettier,
        typescript = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        typescriptreact = biome_or_prettier,
        svelte = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = biome_or_prettier,
        jsonc = biome_or_prettier,
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
      },
      formatters = {
        ["biome-organize-imports"] = {
          require_cwd = true,
        },
        biome = {
          require_cwd = true,
          args = function(self, ctx)
            local cwd = self:cwd(ctx)
            if cwd then
              return { "format", "--config-path", cwd, "--stdin-file-path", "$FILENAME" }
            end
            return { "format", "--stdin-file-path", "$FILENAME" }
          end,
        },
        csharpier = function()
          local useDotnet = not vim.fn.executable("csharpier")
          local command = useDotnet and "dotnet csharpier" or "csharpier"
          local version_out = vim.fn.system(command .. " --version")

          --NOTE: system command returns the command as the first line of the result, need to get the version number on the final line
          local version_result = version_out[#version_out]
          local major_version = tonumber((version_out or ""):match("^(%d+)")) or 0
          local is_new = major_version >= 1
          local args = is_new and { "format", "$FILENAME" } or { "--write-stdout" }
          return {
            command = command,
            args = args,
            stdin = not is_new,
            require_cwd = false,
          }
        end,
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    local format = function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
      require("lint").try_lint("cspell")
    end

    local formatAndSpell = function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
      require("lint").try_lint("cspell")
      require("lint").try_lint("codespell")
    end

    vim.keymap.set({ "n", "v" }, "<leader>f", format, { desc = "Format file or range (in visual mode)" })
    vim.keymap.set({ "n", "v" }, "<leader>fs", formatAndSpell, { desc = "Format file or range (in visual mode)" })
  end,
}
