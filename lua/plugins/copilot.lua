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
          enabled = true,
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
    end,
  },
}
