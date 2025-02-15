-- NOTE: [[ TypeScript Tools ]]
-- this is the typescript lsp plugin
-- this is not through mason but sepparate

return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    lazy = true,
    event = "VeryLazy",
    opts = {
      settings = {
        expose_as_code_action = "all",
        code_lens = "all",
        disable_member_code_lens = true,
      },
    },
  },
}
