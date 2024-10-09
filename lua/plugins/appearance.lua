-- [[ Appearance ]]
return {
  { -- INFO: Material theme
    "marko-cerovac/material.nvim",
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme("material")
      vim.g.material_style = "Ocianic"
    end,
  },
  { -- INFO: Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
