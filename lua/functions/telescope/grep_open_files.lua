local builtin = require("telescope.builtin")

local M = {}

-- grep in open files
local grep_open_files = function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end

M.setup = function()
  vim.keymap.set("n", "<leader>s/", grep_open_files, { desc = "[S]earch [/] in Open Files" })
end

return M
