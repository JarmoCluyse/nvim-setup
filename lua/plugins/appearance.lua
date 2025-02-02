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

      local error_fg = "#FEA3AA"
      local error_bg = "#562224"
      local warn_fg = "#F8B88B"
      local warn_bg = "#4C3A31"
      local info_fg = "#B2CEFE"
      local info_bg = "#2B3C4D"
      local hint_fg = "#BEBDB8"
      local hint_bg = "#3E3D39"

      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = hint_fg, bg = hint_bg })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = info_fg, bg = info_bg })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = warn_fg, bg = warn_bg })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = error_fg, bg = error_bg })

      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = hint_fg })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = info_fg })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = warn_fg })
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = error_fg })
    end,
  },
}
