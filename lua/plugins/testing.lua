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

      "arthur944/neotest-bun",
      "Issafalcon/neotest-dotnet",
      "fredrikaverpil/neotest-golang",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")({
            -- vitestCommand = "npx vitest run",
          }),
          require("neotest-bun")(),

          require("neotest-dotnet")({
            dap = {
              args = { justMyCode = false },
              adapter_name = "coreclr",
            },
            discovery_root = "solution", -- or "solution (.sln)" or "project (.csproj)"
          }),
          require("neotest-golang")({
            runner = "gotestsum",
          }),
        },
      })

      local actions = require("functions.testing.actions")
      vim.keymap.set("n", "<leader>te", require("neotest").summary.toggle, { desc = "Test: explore [T]ests" })
      vim.keymap.set("n", "<leader>to", require("neotest").output.open, { desc = "Test: open test result" })
      vim.keymap.set("n", "<leader>tc", actions.test_cursor, { desc = "Test: [T]est at [C]ursor" })
      vim.keymap.set("n", "<leader>tf", actions.test_file, { desc = "Test: [T]est at [F]ile" })
      vim.keymap.set("n", "<leader>ta", actions.run_all, { desc = "Test: [T]est [A]ll" })
      vim.keymap.set("n", "<leader>tC", actions.debug_cursor, { desc = "Test: [T]est debug [C]ursor" })
      vim.keymap.set("n", "<leader>tF", actions.debug_file, { desc = "Test: [T]est debug [F]ile" })
    end,
  },
}
