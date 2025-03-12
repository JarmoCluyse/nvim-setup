-- NOTE: [[ Copilot ]]
-- copilot configuration

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          hide_during_completion = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = "<M-;>",
            next = "<C-j>",
            prev = "<C-k>",
          },
        },
      })

      -- set color for Copilot suggestions
      local copilot_fg = "#8bd5ca" -- Catppuccin Teal
      vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = copilot_fg })
      vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = copilot_fg })
    end,
  },
}
