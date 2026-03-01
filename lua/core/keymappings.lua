-- NOTE: Basic Keymaps

-- cspell:ignore nohlsearch setloclist uickfix eplace cnext cprev copen

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- INFO: Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- INFO: Resize windows
vim.keymap.set("n", "<C-M-k>", "<cmd>:resize +2<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<C-M-j>", "<cmd>:resize -2<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<C-M-h>", "<cmd>:vertical resize +2<CR>", { desc = "Resize window left" })
-- right needs to be remapped to avoid conflict with the ø key
vim.keymap.set("n", "<C-M-l>", "<cmd>:vertical resize -2<CR>", { desc = "Resize window right" })
vim.keymap.set("n", "ø", "<cmd>:vertical resize -2<CR>", { desc = "Resize window right" })
-- INFO: Move lines
vim.keymap.set("n", "<M-k>", "<cmd>:m -2<CR>", { desc = "Move line up by one" })
vim.keymap.set("n", "<M-j>", "<cmd>:m +1<CR>", { desc = "Move line down by one" })
vim.keymap.set("v", "<M-k>", "<cmd>:m -2<CR>gv=gv", { desc = "Move line up by one" })
vim.keymap.set("v", "<M-j>", "<cmd>:m +1<CR>gv=gv", { desc = "Move line down by one" })
-- INFO: Copy and paste
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("x", "<leader>p", '"_dp', { desc = "Paste and void yank" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void" })
vim.keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "[R]eplace [W]ord under cursor" }
)
-- INFO: Quickfix list
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic as [Q]uickfix list" })
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Move to the next item in the quickfix list" })
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>", { desc = "Move to the previous item in the quickfix list" })
vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open the quickfix list" })
-- INFO: visual block tab
vim.keymap.set("x", "<Tab>", ">gv", { desc = "Shift right" })
vim.keymap.set("x", "<S-Tab>", "<gv", { desc = "Shift left" })

-- INFO: Yank full path to clipboard
vim.keymap.set("n", "<leader>ca", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
end, { desc = "Yank full path to clipboard" })
