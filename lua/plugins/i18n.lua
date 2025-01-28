return {
  "nabekou29/js-i18n.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    namespace_separator = ".",
  },
}
