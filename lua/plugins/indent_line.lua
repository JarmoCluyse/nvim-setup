-- NOTE: [[ Indentation ]]

return {
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  lazy = true,
  event = "VeryLazy",
  { -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
}
