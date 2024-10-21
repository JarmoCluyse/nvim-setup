-- NOTE: [[ Basic Keymaps ]]

-- cspell:ignore nohlsearch setloclist uickfix
local keymap = vim.keymap

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
keymap.set("v", "<K>", "<cmd>:m -2<CR>gv=gv", { desc = "Move line up by one" })
keymap.set("v", "<J>", "<cmd>:m +1<CR>gv=gv", { desc = "Move line down by one" })
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste and void yank" })
keymap.set("n", "<leader>d", '"_d', { desc = "Delete to void" })
keymap.set("v", "<leader>d", '"_d', { desc = "Delete to void" })
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
