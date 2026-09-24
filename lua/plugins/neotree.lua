return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            -- floating preview (default behaviour)
            ["P"] = { "toggle_preview", config = { use_float = true } },
            -- full-width preview: |explorer|preview|
            ["<C-p>"] = { "toggle_preview", config = { use_float = false } },
            -- scroll the preview without leaving the tree
            ["<C-d>"] = { "scroll_preview", config = { direction = -5 } },
            ["<C-u>"] = { "scroll_preview", config = { direction = 5 } },
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          },
        },
      })
      vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>", { desc = "Toggle file explorer" })
    end,
  },
}
