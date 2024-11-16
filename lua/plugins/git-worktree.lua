return {
  "ThePrimeagen/git-worktree.nvim",
  config = function()
    require("git-worktree").setup()

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>lw", function()
      require("telescope").extensions.git_worktree.git_worktrees()
    end, { desc = "Show git worktrees" })

    keymap.set("n", "<leader>la", function()
      require("telescope").extensions.git_worktree.create_git_worktree()
    end, { desc = "Create a git worktree" })
  end,
}
