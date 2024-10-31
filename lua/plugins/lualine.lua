return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    {
      "f-person/git-blame.nvim",
      event = "VeryLazy",
      opts = {
        enabled = true, -- if you want to enable the plugin
        message_template = " <author> • <date> • <sha> • <summary>", -- template for the blame message, check the Message template section for more options
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        virtual_text_column = 0, -- virtual text start column, check Start virtual text at column section for more options
      },
    },
  },
  config = function()
    vim.g.gitblame_display_virtual_text = 0
    local git_blame = require("gitblame")
    require("lualine").setup({
      options = {
        theme = "material",
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
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
          { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available, color = { fg = "#c6c6c6" } },
        },
        lualine_x = {
          "diagnostics",
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = { "filetype", "encoding", "fileformat" },
        lualine_z = { "location" },
      },
    })
  end,
}
