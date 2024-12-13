-- NOTE: [[ Formatting ]]

return { -- formatting plugins
  "stevearc/conform.nvim", -- cspell:disable-line
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
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
        ["*"] = { "cspell", "codespell" },
      },
      -- INFO: format will execute on save
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

    vim.keymap.set({ "n", "v" }, "<leader>f", format, { desc = "Format file or range (in visual mode)" })
  end,
}
