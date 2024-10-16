-- NOTE: [[ Comment code ]]

-- cspell:ignore commentstring

return {
  { -- comment code
    "numToStr/Comment.nvim", -- cspell:disable-line
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring", -- cspell:disable-line
    },

    -- NOTE: usage:
    -- gcc to comment out a line
    -- gbc to comment out a block

    config = function()
      local comment = require("Comment")
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
      ---@diagnostic disable-next-line: missing-fields
      comment.setup({
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
}
