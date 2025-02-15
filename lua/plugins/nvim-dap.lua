-- NOTE: [[ nvim-dap ]]
-- debug adapter protocol client implementation for Neovim

---@diagnostic disable: missing-fields
-- cspell:ignore dapui

return { -- INFO: Debugging and Profiling
  "mfussenegger/nvim-dap", -- cspell:disable-line
  dependencies = {
    "rcarriga/nvim-dap-ui", -- cspell:disable-line
    "nvim-neotest/nvim-nio", -- cspell:disable-line
  },
  lazy = true,
  event = "VeryLazy",
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
        function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = "Debug: Set Breakpoint",
      },
      { "<F7>", dapui.toggle, desc = "Debug: See last session result." },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ed8796", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#91d7e3", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#a6da95", bg = "#31353f" })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapLogPoint",
      { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
    )

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "" },
      controls = {
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
          disconnect = "",
        },
      },
    })
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
