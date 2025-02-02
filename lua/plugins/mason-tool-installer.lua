-- NOTE:[[ mason-tool-installer ]]
-- auto install languages

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim", -- cspell:disable-line
  dependencies = {
    { "williamboman/mason.nvim", config = true },
  },
  config = function()
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
      "eslint_d",
      "prettier",
      "eslint",
      "cspell",
      "codespell",
      "gopls",
      "delve",
      "omnisharp",
      "csharpier",
    })
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
    })
  end,
}
