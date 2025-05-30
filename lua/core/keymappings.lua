-- NOTE: Basic Keymaps

-- cspell:ignore nohlsearch setloclist uickfix eplace cnext cprev copen

local keymap = vim.keymap

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- INFO: Window navigation
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- INFO: Resize windows
keymap.set("n", "<C-M-k>", "<cmd>:resize +2<CR>", { desc = "Resize window up" })
keymap.set("n", "<C-M-j>", "<cmd>:resize -2<CR>", { desc = "Resize window down" })
keymap.set("n", "<C-M-h>", "<cmd>:vertical resize +2<CR>", { desc = "Resize window left" })
-- right needs to be remapped to avoid conflict with the ø key
keymap.set("n", "<C-M-l>", "<cmd>:vertical resize -2<CR>", { desc = "Resize window right" })
keymap.set("n", "ø", "<cmd>:vertical resize -2<CR>", { desc = "Resize window right" })

-- INFO: Move lines
keymap.set("n", "<M-k>", "<cmd>:m -2<CR>", { desc = "Move line up by one" })
keymap.set("n", "<M-j>", "<cmd>:m +1<CR>", { desc = "Move line down by one" })
keymap.set("v", "<M-k>", "<cmd>:m -2<CR>gv=gv", { desc = "Move line up by one" })
keymap.set("v", "<M-j>", "<cmd>:m +1<CR>gv=gv", { desc = "Move line down by one" })

-- INFO: Copy and paste
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste and void yank" })
keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void" })
keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "[R]eplace [W]ord under cursor" }
)

-- INFO: Quickfix list
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic as [Q]uickfix list" })
keymap.set("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Move to the next item in the quickfix list" })
keymap.set("n", "<leader>cp", "<cmd>cprev<CR>", { desc = "Move to the previous item in the quickfix list" })
keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open the quickfix list" })

-- INFO: visual block tab
keymap.set("x", "<Tab>", ">gv", { desc = "Shift right" })
keymap.set("x", "<S-Tab>", "<gv", { desc = "Shift left" })
