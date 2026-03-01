-- cspell:ignore relativenumber showmode breakindent undofile ignorecase smartcase signcolumn updatetime timeoutlen splitright splitbelow list listchars inccommand cursorline scrolloff unnamedplus

-- NOTE: Global nvim options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- NOTE: General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.wrap = false

-- NOTE: UI settings
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 8

-- NOTE: Indentation settings
vim.opt.tabstop = 4 -- Number of visual spaces per TAB
vim.opt.shiftwidth = 2 -- Number of spaces for each indentation
vim.opt.expandtab = true -- Convert tabs to spaces

-- NOTE: [[ Windows specific options ]]
if IsWindows then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-nologo -noprofile -ExecutionPolicy RemoteSigned -command"
  vim.opt.shellxquote = ""
end
