-- NOTE: [[ Autocompletion ]]

-- cspell:ignore luasnip

return {
  { -- INFO: Autocompletion
    "hrsh7th/nvim-cmp", -- cspell:disable-line
    event = "InsertEnter",
    -- cspell:disable
    dependencies = {
      { -- INFO: snippets
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip",
        },
      },
      "hrsh7th/cmp-nvim-lsp", -- INFO: add LSP capabilities to autocomplete
      "hrsh7th/cmp-path", -- INFO: add path completion
    },
    -- cspell:enable
    config = function()
      local cmp = require("cmp")

      require("luasnip.loaders.from_vscode").lazy_load()
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      -- <c-l> will move you to the right of each of the expansion locations.
      local luasnip_expand = function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end

      -- <c-h> is similar, except moving you backwards.
      local luasnip_jump_back = function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end

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
        completion = { completeopt = "menu,menuone,noinsert" }, -- cspell:disable-line
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-l>"] = cmp.mapping(luasnip_expand, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(luasnip_jump_back, { "i", "s" }),
        }),
        sources = {
          {
            name = "lazydev",
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      })
    end,
  },
}
