local M = {}

--- Function to find all files without ignores
local find_all = function()
  local builtin = require("telescope.builtin")

  builtin.find_files({
    prompt_title = "Find All",
    find_command = { "fd", "-H", "--type", "f", "-I" },
  })
end

--- Setup function to map the keybinding for finding all files without an ignore
M.setup = function() vim.keymap.set("n", "<leader>sj", find_all, { desc = "[S]earch [J]all" }) end

return M
