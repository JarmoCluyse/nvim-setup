-- NOTE: [[ lualine ]]
-- this is the status line at the bottom of the editor

---@diagnostic disable: undefined-field
-- cspell:ignore lualine gitblame devicons noice worktree fileformat

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/noice.nvim",
  },
  config = function()
    vim.g.gitblame_display_virtual_text = 0
    local git_utils = require("functions.git-utils")
    local noice_status = require("noice").api.status

    require("lualine").setup({
      options = {
        theme = "material",
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
          {
            noice_status.mode.get,
            cond = noice_status.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            noice_status.search.get,
            cond = noice_status.search.has,
            color = { fg = "#ff9e64" },
          },
          {
            noice_status.command.get,
            cond = noice_status.command.has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = { "filetype", "encoding", "fileformat" },
        lualine_z = { "location" },
      },
    })
  end,
}
