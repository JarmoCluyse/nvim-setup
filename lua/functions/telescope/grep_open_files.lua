local M = {}

--- Function to perform live grep search in open files using Telescope.
local grep_open_files = function()
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end

--- Setup function to map the keybinding for live grep search in open files.
M.setup = function()
  vim.keymap.set("n", "<leader>s/", grep_open_files, { desc = "[S]earch [/] in Open Files" })
end

return M
