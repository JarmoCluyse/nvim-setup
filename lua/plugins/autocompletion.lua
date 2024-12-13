-- NOTE: [[ Autocompletion ]]

-- cspell:ignore luasnip hrsh menuone noinsert completeopt

return {
  { -- INFO: Autocompletion
    "hrsh7th/nvim-cmp", -- cspell:disable-line
    dependencies = {
      "L3MON4D3/LuaSnip", -- INFO: snippets, config is in snippets.lua
      "hrsh7th/cmp-nvim-lsp", -- INFO: add LSP capabilities to autocomplete
      "hrsh7th/cmp-path", -- INFO: add path completion
    },
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
