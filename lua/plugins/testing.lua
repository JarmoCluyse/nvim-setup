--  NOTE: [[ Neotest ]] is a testing framework for [[ Neovim ]] that supports multiple test runners.

---@diagnostic disable: missing-fields

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "Issafalcon/neotest-dotnet",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")({

            vitestCommand = "npx vitest run",
          }),
          require("neotest-dotnet")({
            dap = {
              args = { justMyCode = false },
              adapter_name = "coreclr",
              discovery_root = "solution", -- or "solution (.sln)" or "project (.csproj)"
            },
          }),
        },
      })

      local function test_file()
        require("neotest").run.run(vim.fn.expand("%"))
      end

      local function debug_cursor()
        require("neotest").run.run({ strategy = "dap" })
      end

      local function debug_file()
        require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
      end

      vim.keymap.set("n", "<leader>tc", require("neotest").run.run, { desc = "Run [T]est at [C]ursor" })
      vim.keymap.set("n", "<leader>tf", test_file, { desc = "Run [T]est at [F]ile" })
      vim.keymap.set("n", "<leader>tC", debug_cursor, { desc = "debug [T]est at [C]ursor" })
      vim.keymap.set("n", "<leader>tF", debug_file, { desc = "test [T]est at [F]ile" })

      vim.keymap.set("n", "<leader>te", require("neotest").summary.toggle, { desc = "explore [T]ests" })
    end,
  },
}
