-- NOTE: [[ TypeScript Tools ]] is a plugin that provides TypeScript language support for [[ Neovim ]].

return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(client, bufnr)
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
      end,
      settings = {
        expose_as_code_action = "all",
        code_lens = "all",
        disable_member_code_lens = true,
      },
    },
  },
}
