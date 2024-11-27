return {
  { -- INFO: Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim", -- cspell:disable-line
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({})

      vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]odos" })
    end,
  },
}
