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
        "debugloop/telescope-undo.nvim",
        -- ["<CR>"] = require("telescope-undo.actions").yank_additions,
        -- ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
        -- ["<C-r>"] = require("telescope-undo.actions").restore,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      {
        "isak102/telescope-git-file-history.nvim",
        dependencies = {
          "tpope/vim-fugitive",
        },
      },
    },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local state = require("telescope.state")
      local action_state = require("telescope.actions.state")

      -- Slow scrolling in preview window
      -- @param prompt_buf_nr number: The prompt buffer number
      -- @param direction number: The direction to scroll in
      local slow_scroll = function(prompt_buf_nr, direction)
        local previewer = action_state.get_current_picker(prompt_buf_nr).previewer
        local status = state.get_status(prompt_buf_nr)

        -- Check if we actually have a previewer and a preview window
        if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
          return
        end

        previewer:scroll_fn(1 * direction)
      end

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
                slow_scroll(buf_nr, 1)
              end,
              ["<C-y>"] = function(buf_nr)
                slow_scroll(buf_nr, -1)
              end,
              ["<c-w>"] = actions.delete_buffer,
            },
            n = {
              ["<c-w>"] = actions.delete_buffer,
              ["dd"] = actions.delete_buffer,
            },
          },
        },
      })
      -- load extensions
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension, "undo")

      local extensions = require("telescope").extensions

      -- Setup keymaps
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
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>u", extensions.undo.undo, { desc = "[U]ndo history" })

      require("plugins.telescope_custom.current_buffer_fuzzy").setup()
      require("plugins.telescope_custom.grep_open_files").setup()
      require("plugins.telescope_custom.config_files").setup()
      require("plugins.telescope_custom.multigrep").setup()
    end,
  },
}
