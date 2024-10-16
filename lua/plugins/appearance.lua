-- NOTE: [[ Editor appearance ]]

return {
  { -- INFO: Material theme
    "marko-cerovac/material.nvim", -- cspell:disable-line

    init = function()
      vim.cmd.colorscheme("material")
      vim.g.material_style = "Ocianic" -- cspell:disable-line
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
