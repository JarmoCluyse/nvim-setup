return {
  {
    "crnvl96/lazydocker.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {}, -- automatically calls `require("lazydocker").setup()`
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ld", "<cmd>LazyDocker<cr>", desc = "Open lazy docker" },
    },
  },
}
