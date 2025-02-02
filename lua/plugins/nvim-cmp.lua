-- NOTE: [[ nvim-cmp ]]
-- adds items to the completion menu and manages the completion menu.

-- cspell:ignore luasnip hrsh menuone noinsert completeopt

return {
  {
    "hrsh7th/nvim-cmp", -- cspell:disable-line
    dependencies = {
      "L3MON4D3/LuaSnip", -- snippet engine
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/cmp-path", -- path source for nvim-cmp
    },
    lazy = true,
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local actions = require("functions.luasnip_actions")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-l>"] = cmp.mapping(actions.luasnip_expand, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(actions.luasnip_jump_back, { "i", "s" }),
        }),
        sources = {
          { name = "lazydev", group_index = 0 },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      })
    end,
  },
}
