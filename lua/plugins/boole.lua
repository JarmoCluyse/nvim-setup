-- NOTE: [[ Boole ]]
-- toggle boolean values

return {
  "nat-418/boole.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    mappings = {
      increment = "<C-a>",
      decrement = "<C-x>",
    },
    -- User defined loops
    additions = {
      -- { "enable", "disable" },
      { "&&", "||" },
    },
  },
}
