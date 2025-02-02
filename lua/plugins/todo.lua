-- NOTE: [[ TODO ]]
-- highlight and search for todos

return {
  { 
    "folke/todo-comments.nvim", -- cspell:disable-line
    lazy = true,
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({})

      vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]odos" })
    end,
  },
}
