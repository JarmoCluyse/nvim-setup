-- NOTE: [[ Formatting ]]
-- plugin to run formatting
-- TODO: add progress!

return {
  "stevearc/conform.nvim", -- cspell:disable-line
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        cs = { "csharpier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
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
