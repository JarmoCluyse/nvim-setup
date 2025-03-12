-- NOTE: [[ C# ]]
-- plugins for C#
-- run and debug C# code
-- add items to C# project

return {
  {
    -- "iabdelkareem/csharp.nvim", -- temporary until PR is merged
    "JarmoCluyse/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required, automatically installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
      "seblyng/roslyn.nvim",
    },
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("csharp").setup({
        lsp = {
          -- omnisharp = {
          --   enable = false,
          -- },
          -- roslyn = {
          --   enable = false,
          -- },
        },
      })

      local csharp = require("csharp")

      vim.keymap.set("n", "<leader>nd", csharp.debug_project, { desc = ".NET Debug project" })
      vim.keymap.set("n", "<leader>ne", csharp.run_project, { desc = ".NET Run project" })
    end,
  },
  {
    "MoaidHathot/dotnet.nvim",
    branch = "dev",
    cmd = "DotnetUI",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "<leader>na", "<cmd>:DotnetUI new_item<CR>", { desc = ".NET new item", silent = true } },
      { "<leader>nb", "<cmd>:DotnetUI file bootstrap<CR>", { desc = ".NET bootstrap class", silent = true } },
      {
        "<leader>nra",
        "<cmd>:DotnetUI project reference add<CR>",
        { desc = ".NET add project reference", silent = true },
      },
      {
        "<leader>nrr",
        "<cmd>:DotnetUI project reference remove<CR>",
        { desc = ".NET remove project reference", silent = true },
      },
      { "<leader>npa", "<cmd>:DotnetUI project package add<CR>", { desc = ".NET ada project package", silent = true } },
      {
        "<leader>npr",
        "<cmd>:DotnetUI project package remove<CR>",
        { desc = ".NET remove project package", silent = true },
      },
    },
    opts = {
      project_selection = {
        path_display = "filename_first",
      },
    },
  },
}
