local M = {}

-- cspell:ignore bufnr

--- Function to find and list existing buffers using Telescope.
local find_Buffers = function()
  local builtin = require("telescope.builtin")
  local action_state = require("telescope.actions.state")

  --- Delete the selected buffer or all the buffers selected using multi selection.
  --- this is to copied from telescope actions, because I want to be able to force close buffers
  ---@param prompt_bufnr number: The prompt bufnr
  local delete_buffer = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    current_picker:delete_selection(function(selection)
      local ok = pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = true })
      return ok
    end)
  end

  builtin.buffers({
    attach_mappings = function(_, map)
      map("i", "<c-d>", delete_buffer)
      map("n", "<c-d>", delete_buffer)
      return true
    end,
  })
end

--- Setup function to map the keybinding for finding buffers.
M.setup = function() vim.keymap.set("n", "<leader><leader>", find_Buffers, { desc = "[ ] Find existing buffers" }) end

return M
