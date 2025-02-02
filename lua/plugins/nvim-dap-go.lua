-- NOTE: [[ nvim-dap-go ]]
-- dap adapter for go

return {
  "leoluz/nvim-dap-go", -- cspell:disable-line
  dependencies = {
    "mfussenegger/nvim-dap", -- cspell:disable-line
  },
  config = function()
    require("dap-go").setup({
      delve = {
        detached = vim.fn.has("win32") == 0,
      },
    })
  end,
}
