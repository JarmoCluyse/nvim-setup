-- NOTE: [[ Editor appearance ]]
-- add the theme
-- set custom colors

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

      local error_fg = "#FEA3AA"
      local warn_fg = "#F8B88B"
      local info_fg = "#B2CEFE"
      local hint_fg = "#BEBDB8"

      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = error_fg })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = warn_fg })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = info_fg })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = hint_fg })

      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = error_fg })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = warn_fg })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = info_fg })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = hint_fg })

      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
    end,
  },
}
