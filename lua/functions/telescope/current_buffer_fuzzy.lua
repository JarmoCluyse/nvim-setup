local M = {}

--- Function to perform a fuzzy search in the current buffer using Telescope.
local current_buffer_fuzzy_find = function()
  local builtin = require("telescope.builtin")
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end

--- Setup function to map the keybinding for fuzzy searching in the current buffer.
M.setup = function()
  vim.keymap.set("n", "<leader>/", current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
end

return M
