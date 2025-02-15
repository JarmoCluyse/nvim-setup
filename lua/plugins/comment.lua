-- NOTE: [[ Comment code ]]
-- put the line / block in comment
-- awereness in files (tsx for example)

-- cspell:ignore commentstring JoosepAlviste

return {
  {
    "numToStr/Comment.nvim", -- cspell:disable-line
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },

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
