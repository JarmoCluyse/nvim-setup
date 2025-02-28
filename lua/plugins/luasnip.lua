return {
  { -- INFO: snippets
    "L3MON4D3/LuaSnip",
    -- lazy = true,
    -- event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local ls = require("luasnip")
      ls.config.setup({})
      require("functions.luasnip_snippets").setup()

      vim.keymap.set({ "i", "s" }, "<A-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)

      vim.keymap.set({ "i", "s" }, "<A-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<A-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },
}
