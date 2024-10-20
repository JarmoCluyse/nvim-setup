-- NOTE: [[ Boole ]] toggle boolean values

return {
  "nat-418/boole.nvim",
  opts = {
    mappings = {
      increment = "<C-a>",
      decrement = "<C-x>",
    },
    -- User defined loops
    additions = {
      { "tic", "tac", "toe" },
    },
  },
}
