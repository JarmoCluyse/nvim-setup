-- NOTE: [[ lualine ]]
-- this is the status line at the bottom of the editor

---@diagnostic disable: undefined-field
-- cspell:ignore lualine gitblame devicons worktree fileformat

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.gitblame_display_virtual_text = 0
    local git_utils = require("functions.git-utils")

    require("lualine").setup({
      options = {
        theme = "catppuccin-mocha",
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { git_utils.get_git_worktree, "branch", "diff" },
        lualine_c = {
          {
            "filename",
            symbols = {
              modified = "󱇧", -- Text to show when the file is modified.
              readonly = "󰷊", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "󰷆", -- Text to show for unnamed buffers.
              newfile = "󰝒", -- Text to show for newly created file before first write
            },
          },
        },
        lualine_x = {
          "diagnostics",
        },
        lualine_y = { "filetype", "encoding", "fileformat" },
        lualine_z = { "location" },
      },
    })
  end,
}
