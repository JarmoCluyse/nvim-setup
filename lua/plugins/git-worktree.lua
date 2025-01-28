-- NOTE: [[ git-worktree ]]
-- this is a plugin that provides git worktree support for Neovim.

-- cspell:ignore worktree worktrees ThePrimeagen
--
return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("git-worktree").setup()

    local keymap = vim.keymap -- for conciseness
    local git_worktree = require("telescope").extensions.git_worktree
    local Worktree = require("git-worktree")

    -- op = Operations.Switch, Operations.Create, Operations.Delete
    -- metadata = table of useful values (structure dependent on op)
    --      Switch
    --          path = path you switched to
    --          prev_path = previous worktree path
    --      Create
    --          path = path where worktree created
    --          branch = branch name
    --          upstream = upstream remote name
    --      Delete
    --          path = path where worktree deleted

    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Switch then
        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
      end
    end)

    keymap.set("n", "<leader>lw", git_worktree.git_worktrees, { desc = "Show git worktrees" })
    keymap.set("n", "<leader>la", git_worktree.create_git_worktree, { desc = "Create a git worktree" })
  end,
}
