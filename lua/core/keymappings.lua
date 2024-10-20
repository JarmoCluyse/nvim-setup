-- NOTE: [[ Basic Keymaps ]]

-- cspell:ignore nohlsearch setloclist uickfix

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("v", "<K>", "<cmd>:m -2<CR>gv=gv", { desc = "Move line up by one" })
vim.keymap.set("v", "<J>", "<cmd>:m +1<CR>gv=gv", { desc = "Move line down by one" })
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste and void yank" })
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete to void" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete to void" })
