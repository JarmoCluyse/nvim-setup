local M = {}

-- find config files
local find_folders = function()
  local builtin = require("telescope.builtin")

  builtin.find_files({
    prompt_title = "Find Folders",
    find_command = { "fd", "--type", "d" },
  })
end

M.setup = function()
  vim.keymap.set("n", "<leader>sa", find_folders, { desc = "[S]earch [A]folders" })
end

return M
