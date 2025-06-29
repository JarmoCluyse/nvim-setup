-- NOTE: [[ Harpoon ]]
-- A bookmarking plugin for neovim

return {
  "ThePrimeagen/harpoon",
  lazy = true,
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add to harpoon list" })
    vim.keymap.set(
      "n",
      "<leader>he",
      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Toggle harpoon quicklist" }
    )

    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
  end,
}
