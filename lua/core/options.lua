-- NOTE: [[ Global nvim options ]]

-- cspell:ignore relativenumber showmode breakindent undofile ignorecase smartcase signcolumn updatetime timeoutlen splitright splitbelow list listchars inccommand cursorline scrolloff unnamedplus

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.wrap = false
-- sync clipboard with system clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 50
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
