-- NOTE: [[ Indentation ]]
-- Detect tabstop and shiftwidth automatically

return {
  "tpope/vim-sleuth",
  lazy = true,
  event = "VeryLazy",
  { -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
}
