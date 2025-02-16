--  NOTE: [[ Neotest ]]
-- is a testing framework for Neovim

---@diagnostic disable: missing-fields

return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "uga-rosa/utf8.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- FIXME: return to original repo after PR is merged
      -- "marilari88/neotest-vitest",
      "JarmoCluyse/neotest-vitest",
      "Issafalcon/neotest-dotnet",
      "fredrikaverpil/neotest-golang",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")({
            -- vitestCommand = "npx vitest run",
          }),
          require("neotest-dotnet")({
            dap = {
              args = { justMyCode = false },
              adapter_name = "coreclr",
              discovery_root = "solution", -- or "solution (.sln)" or "project (.csproj)"
            },
          }),
          require("neotest-golang")({
            runner = "gotestsum",
          }),
        },
      })

      local actions = require("functions.testing.actions")
      vim.keymap.set("n", "<leader>te", require("neotest").summary.toggle, { desc = "explore [T]ests" })
      vim.keymap.set("n", "<leader>tc", actions.test_cursor, { desc = "Run [T]est at [C]ursor" })
      vim.keymap.set("n", "<leader>tf", actions.test_file, { desc = "Run [T]est at [F]ile" })
      vim.keymap.set("n", "<leader>tC", actions.debug_cursor, { desc = "debug [T]est at [C]ursor" })
      vim.keymap.set("n", "<leader>tF", actions.debug_file, { desc = "test [T]est at [F]ile" })
    end,
  },
}
