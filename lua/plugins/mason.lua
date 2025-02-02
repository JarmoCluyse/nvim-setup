-- NOTE: [[ Mason ]]
-- tool for installing LSP

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
}
