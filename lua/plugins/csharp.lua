return {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  },
  config = function()
    require("csharp").setup({
      lsp = {
        omnisharp = {
          enable = true,
        },
        roslyn = {
          enable = false,
          cmd_path = "C:/Users/COMAR/AppData/Local/nvim-data/csharp/roslyn-lsp",
        },
      },
    })
  end,
}
