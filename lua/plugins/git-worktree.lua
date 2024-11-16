-- NOTE: [[ git-worktree ]]
-- this is a plugin that provides git worktree support for Neovim.

-- cspell:ignore worktree worktrees ThePrimeagen
--
return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("git-worktree").setup()

    local keymap = vim.keymap -- for conciseness
    local git_worktree = require("telescope").extensions.git_worktree

    keymap.set("n", "<leader>lw", git_worktree.git_worktrees, { desc = "Show git worktrees" })
    keymap.set("n", "<leader>la", git_worktree.create_git_worktree, { desc = "Create a git worktree" })
  end,
}
