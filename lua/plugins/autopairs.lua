-- NOTE: [[ autopairs ]]
-- auto close brackets, quotes and autotag for html

-- cspell:ignore autotag windwp hrsh7th

return {
  {
    "windwp/nvim-autopairs", -- cspell:disable-line
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp", -- completion engine
    },
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "windwp/nvim-ts-autotag", -- cspell:disable-line
    lazy = true,
    event = "InsertEnter",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        per_filetype = {
          ["html"] = {
            enable_close = false,
          },
        },
      })
    end,
  },
}
