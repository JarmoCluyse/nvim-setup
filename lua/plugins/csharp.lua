return {
  -- "iabdelkareem/csharp.nvim", -- temporary until PR is merged
  "JarmoCluyse/csharp.nvim",
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

    local keymap = vim.keymap
    local csharp = require("csharp")

    keymap.set("n", "<leader>cd", csharp.debug_project, { desc = "csharp Debug project" })
    keymap.set("n", "<leader>cr", csharp.run_project, { desc = "csharp Run project" })
  end,
}
