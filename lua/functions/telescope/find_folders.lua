local M = {}

-- find config files
local find_folders = function()
  require("telescope.builtin").find_files({
    find_command = { "fd", "--type", "d" },
  })
end

M.setup = function()
  vim.keymap.set("n", "<leader>sa", find_folders, { desc = "[S]earch [A]folders" })
end

return M
