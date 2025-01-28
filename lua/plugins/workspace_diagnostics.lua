return {
  {
    "artemave/workspace-diagnostics.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<space>xw", function()
        for _, client in ipairs(vim.lsp.get_clients()) do
          require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
        end
      end, { desc = "Populate workspace diagnostics" })
    end,
  },
}
