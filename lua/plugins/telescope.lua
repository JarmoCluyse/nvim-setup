-- NOTE: [[ Telescope ]] is a highly extensible fuzzy finder plugin for [[ Neovim ]].

return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      local builtin = require("telescope.builtin")
      local scrolling = require("functions.scrolling")
      -- Setup Telescope
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-e>"] = function(buf_nr)
                scrolling.slow_scroll(buf_nr, 1)
              end,
              ["<C-y>"] = function(buf_nr)
                scrolling.slow_scroll(buf_nr, -1)
              end,
            },
          },
        },
      })
      -- load extensions
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      -- set simpel keymaps
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sp", builtin.git_files, { desc = "[S]earch Git [P]roject Files" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sG", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- set custom telescope keymaps
      require("plugins.telescope_custom.current_buffer_fuzzy").setup()
      require("plugins.telescope_custom.grep_open_files").setup()
      require("plugins.telescope_custom.config_files").setup()
      require("plugins.telescope_custom.multigrep").setup()
      require("plugins.telescope_custom.buffers").setup()
    end,
  },
}
