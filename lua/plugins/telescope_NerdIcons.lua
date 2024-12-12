-- NOTE: search for nerd icons using [[ Telescope ]].

-- cspell:ignore 2kabhishek stevearc earch

return {
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
    event = "VimEnter",
    lazy = true,
    config = function()
      print("Loading nerdy.nvim")
      local telescope = require("telescope")
      telescope.load_extension("nerdy")

      local extensions = telescope.extensions
      vim.keymap.set("n", "<leader>si", extensions.nerdy.nerdy, { desc = "[S]earch nerd [i]cons" })
    end,
  },
}
