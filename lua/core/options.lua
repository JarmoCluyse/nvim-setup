-- NOTE: Global nvim options

-- cspell:ignore relativenumber showmode breakindent undofile ignorecase smartcase signcolumn updatetime timeoutlen splitright splitbelow list listchars inccommand cursorline scrolloff unnamedplus

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.wrap = false

-- sync clipboard with system clipboard
-- vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)

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

-- Set tab width to 2 spaces and use spaces instead of tabs
opt.tabstop = 4 -- Number of visual spaces per TAB
opt.shiftwidth = 2 -- Number of spaces for each indentation
opt.expandtab = true -- Convert tabs to spaces

-- NOTE: [[ Windows specific options ]]
--
---@diagnostic disable-next-line: undefined-field
local isWindows = vim.loop.os_uname().sysname:find("Windows") and true or false

if isWindows then
  opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-nologo -noprofile -ExecutionPolicy RemoteSigned -command"
  vim.opt.shellxquote = ""
end
