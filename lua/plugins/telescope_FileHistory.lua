-- NOTE: look at file history using [[ Telescope ]].

-- cspell:ignore

return {
  {
    "isak102/telescope-git-file-history.nvim",
    dependencies = {
      "tpope/vim-fugitive",
      "nvim-telescope/telescope.nvim",
    },
    event = "VimEnter",
    lazy = true,
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("git_file_history")
      -- ["<CR>"] = require("telescope-undo.actions").yank_additions,
      -- ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
      -- ["<C-r>"] = require("telescope-undo.actions").restore,
      local extensions = telescope.extensions
      vim.keymap.set("n", "<leader>sb", extensions.git_file_history.git_file_history, { desc = "[S]earch git history [B]lames" })
    end,
  },
}
