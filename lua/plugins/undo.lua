-- NOTE: [[ undo ]] is a plugin that provides a telescope extension for undo history.

return {
  "debugloop/telescope-undo.nvim", -- cspell: disable-line
  keys = {
    { -- lazy style key map
      "<leader>u",
      "<cmd>Telescope undo<cr>",
      desc = "undo history",
    },
  },
  -- ["<CR>"] = require("telescope-undo.actions").yank_additions,
  -- ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
  -- ["<C-r>"] = require("telescope-undo.actions").restore,
  opts = {
    extensions = {
      undo = {},
    },
  },
  config = function()
    require("telescope").load_extension("undo")
  end,
}
