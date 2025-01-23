-- NOTE: [[ Editor appearance ]]

-- cspell:ignore catppuccin

return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
      -- disable background for all windows
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      -- set color for Copilot suggestions
      local copilot_fg = "#93BDB2"
      vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = copilot_fg })
      vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = copilot_fg })
    end,
  },
}
