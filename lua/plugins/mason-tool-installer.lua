-- NOTE:[[ mason-tool-installer ]]
-- auto install languages

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim", -- cspell:disable-line
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local ensure_installed = {}
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
      "eslint_d",
      "prettier",
      "cssls",
      "eslint",
      "cspell",
      "codespell",
      "gopls",
      "lua_ls",
      "delve",
      "roslyn",
      "ts_ls",
      "csharpier",
    })
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
    })
  end,
}
