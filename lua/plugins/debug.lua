-- NOTE: [[ Debugging ]]

---@diagnostic disable: missing-fields
-- cspell:ignore dapui

return {
  "mfussenegger/nvim-dap", -- cspell:disable-line
  dependencies = {
    "rcarriga/nvim-dap-ui", -- cspell:disable-line
    "nvim-neotest/nvim-nio", -- cspell:disable-line
    "williamboman/mason.nvim", -- cspell:disable-line
    "jay-babu/mason-nvim-dap.nvim", -- cspell:disable-line
    "leoluz/nvim-dap-go", -- cspell:disable-line
  },
  keys = function(_, keys)
    local dap = require("dap")
    local dapui = require("dapui")
    return {
      { "<F5>", dap.continue, desc = "Debug: Start/Continue" },
      { "<F1>", dap.step_into, desc = "Debug: Step Into" },
      { "<F2>", dap.step_over, desc = "Debug: Step Over" },
      { "<F3>", dap.step_out, desc = "Debug: Step Out" },
      { "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
      {
        "<leader>B",
        function()
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug: Set Breakpoint",
      },
      { "<F7>", dapui.toggle, desc = "Debug: See last session result." },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        "delve",
      },
    })
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
    require("dap-go").setup({
      delve = {
        detached = vim.fn.has("win32") == 0,
      },
    })
  end,
}
