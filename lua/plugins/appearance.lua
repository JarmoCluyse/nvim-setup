-- NOTE: [[ Editor appearance ]]

-- cspell:ignore catppuccin

return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end,
  },
  { -- INFO: Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim", -- cspell:disable-line
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  { -- INFO: boards for telescope
    "stevearc/dressing.nvim", -- cspell:disable-line
    event = "VeryLazy",
  },
}
