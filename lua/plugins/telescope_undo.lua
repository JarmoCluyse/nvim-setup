-- NOTE: look at undo tree[[ Telescope ]].

-- cspell:ignore debugloop

return {
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "VimEnter",
    lazy = true,
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("undo")

      local extensions = telescope.extensions
      vim.keymap.set("n", "<leader>su", extensions.undo.undo, { desc = "[U]ndo history" })
    end,
  },
}
