local M = {}

-- Fuzzy find in current buffer
local current_buffer_fuzzy_find = function()
  local builtin = require("telescope.builtin")
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end

M.setup = function()
  vim.keymap.set("n", "<leader>/", current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
end

return M
