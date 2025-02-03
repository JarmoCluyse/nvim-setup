-- NOTE: [[ Dadbod ]]
-- Database client for nvim

return {
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  {
    "kristijanhusak/vim-dadbod-ui",
    config = function() vim.keymap.set("n", "<F10>", "<CMD>DBUIToggle<CR>", { desc = "Toggle Dadbod UI" }) end,
  },
}
