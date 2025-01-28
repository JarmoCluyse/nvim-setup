local M = {}

--- Function to find and list folders using Telescope.
local find_folders = function()
  local builtin = require("telescope.builtin")

  builtin.find_files({
    prompt_title = "Find Folders",
    find_command = { "fd", "--type", "d" },
  })
end

--- Setup function to map the keybinding for finding folders.
M.setup = function()
  vim.keymap.set("n", "<leader>sa", find_folders, { desc = "[S]earch [A]folders" })
end

return M
