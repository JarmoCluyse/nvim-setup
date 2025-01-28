local M = {}

--- Function to find and list existing buffers using Telescope.
local find_Buffers = function()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  builtin.buffers({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.delete_buffer)
      map("n", "<c-d>", actions.delete_buffer)
      return true
    end,
  })
end

--- Setup function to map the keybinding for finding buffers.
M.setup = function()
  vim.keymap.set("n", "<leader><leader>", find_Buffers, { desc = "[ ] Find existing buffers" })
end

return M
