return {
  { -- INFO: snippets
    "L3MON4D3/LuaSnip",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.setup({})
    end,
  },
}
