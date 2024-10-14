return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")({

            vitestCommand = "npx vitest run",
          }),
        },
      })
      vim.keymap.set("n", "<leader>tc", require("neotest").run.run, { desc = "Run [T]est at [C]ursor" })

      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "Run [T]est at [F]ile" })
    end,
  },
}
