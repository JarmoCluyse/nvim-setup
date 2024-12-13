-- NOTE: [[ autopairs ]]

-- cspell:ignore autotag

return {
  -- INFO: auto add closing brackets, quotes, etc
  {
    "windwp/nvim-autopairs", -- cspell:disable-line
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp", -- cspell:disable-line
    },
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -- INFO: auto close html tags
  {
    "windwp/nvim-ts-autotag", -- cspell:disable-line
    config = function()
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
