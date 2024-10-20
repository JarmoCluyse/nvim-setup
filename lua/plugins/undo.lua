-- NOTE: [[ undo ]] is a plugin that provides a telescope extension for undo history.

return {
  "debugloop/telescope-undo.nvim",
  keys = {
    { -- lazy style key map
      "<leader>u",
      "<cmd>Telescope undo<cr>",
      desc = "undo history",
    },
  },
  opts = {
    extensions = {
      undo = {},
    },
  },
  config = function()
    require("telescope").load_extension("undo")
  end,
}
