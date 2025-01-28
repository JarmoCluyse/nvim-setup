local M = {}

--- Function to find and list Neovim configuration files using Telescope.
local find_config_files = function()
  local builtin = require("telescope.builtin")
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "Find Config Files",
  })
end

--- Setup function to map the keybinding for finding Neovim configuration files.
M.setup = function()
  vim.keymap.set("n", "<leader>sn", find_config_files, { desc = "[S]earch [N]eovim files" })
end

return M
