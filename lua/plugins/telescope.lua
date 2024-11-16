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
      {
        "isak102/telescope-git-file-history.nvim",
        dependencies = {
          "tpope/vim-fugitive",
        },
      },
      {
        "2kabhishek/nerdy.nvim",
        dependencies = {
          "stevearc/dressing.nvim",
          "nvim-telescope/telescope.nvim",
        },
        cmd = "Nerdy",
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
      pcall(require("telescope").load_extension, "git_file_history")
      require("telescope").load_extension("nerdy")
      local extensions = require("telescope").extensions

      -- Fuzzy find in current buffer
      local current_buffer_fuzzy_find = function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end

      -- grep in open files
      local grep_open_files = function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end

      -- find config files
      local find_config_files = function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
          prompt_title = "Find Config Files",
        })
      end

      -- Setup keymaps
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sp", builtin.git_files, { desc = "[S]earch Git [P]roject Files" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>si", extensions.nerdy.nerdy, { desc = "[S]earch nerd [i]cons" })
      vim.keymap.set("n", "<leader>sb", extensions.git_file_history.git_file_history, { desc = "[S]earch git history [B]lames" })
      vim.keymap.set("n", "<leader>/", current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
      vim.keymap.set("n", "<leader>s/", grep_open_files, { desc = "[S]earch [/] in Open Files" })
      vim.keymap.set("n", "<leader>sn", find_config_files, { desc = "[S]earch [N]eovim files" })
    end,
  },
}
