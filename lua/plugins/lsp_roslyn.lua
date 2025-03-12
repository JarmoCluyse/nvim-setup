-- NOTE: [[ Roslyn ]]
--lsp for c#

return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  config = function()
    require("roslyn").setup({
      config = {},
      broad_search = true,
    })
    -- create commands
    require("functions.roslyn_utils").setup()
  end,
}
