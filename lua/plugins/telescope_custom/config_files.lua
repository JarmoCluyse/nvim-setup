local builtin = require("telescope.builtin")

local M = {}

-- find config files
local find_config_files = function()
  builtin.find_files({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "Find Config Files",
  })
end

M.setup = function()
  vim.keymap.set("n", "<leader>sn", find_config_files, { desc = "[S]earch [N]eovim files" })
end

return M
