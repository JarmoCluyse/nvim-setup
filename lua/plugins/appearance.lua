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
      -- transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        harpoon = true,
        mason = true,
        neotest = true,
        dap_ui = true,
        snacks = true,
        fidget = true,
        mini = {
          enabled = true,
          indentscope_color = "lavender",
        },
        telescope = {
          enabled = true,
          -- style = "nvchad"
        },
        lsp_trouble = true,
        which_key = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
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

      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
        underline = {
          severity = vim.diagnostic.severity.INFO,
        },
        float = {
          border = "single",
        },
        virtual_text = true,
      })
    end,
  },
}
