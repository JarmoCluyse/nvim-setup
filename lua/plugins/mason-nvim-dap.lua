-- NOTE: [[ masom-nvim-dap ]]
-- auto install for dap

return {
  "jay-babu/mason-nvim-dap.nvim", -- cspell:disable-line
  dependencies = {
    "williamboman/mason.nvim", -- cspell:disable-line
  },
  config = function()
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        "delve", -- GO debugger
        "coreclr", -- dotnet debugger
      },
    })
  end,
}
