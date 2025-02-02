-- NOTE: [[ Lazydev ]]
-- configures luaLS for editing neovim

return {
  "folke/lazydev.nvim",
  lazy = true,
  event = "VeryLazy",
  ft = "lua",
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}
