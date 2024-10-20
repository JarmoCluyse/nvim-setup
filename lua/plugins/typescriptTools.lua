-- NOTE: [[ TypeScript Tools ]] is a plugin that provides TypeScript language support for [[ Neovim ]].

return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        code_lens = "all",
      },
    },
  },
}
