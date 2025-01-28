local M = {}

--- Opens a Telescope picker with help actions from CopilotChat.
function M.help_actions()
  local actions = require("CopilotChat.actions")
  local telescope = require("CopilotChat.integrations.telescope")
  telescope.pick(actions.help_actions())
end

--- Opens a Telescope picker with prompt actions from CopilotChat.
function M.prompt_actions()
  local actions = require("CopilotChat.actions")
  local telescope = require("CopilotChat.integrations.telescope")
  telescope.pick(actions.prompt_actions())
end

--- Opens a Telescope picker with visual prompt actions from CopilotChat.
function M.prompt_actions_visual()
  local actions = require("CopilotChat.actions")
  local telescope = require("CopilotChat.integrations.telescope")
  telescope.pick(actions.prompt_actions({ selection = require("CopilotChat.select").visual }))
end

--- Prompts the user for input and sends it to CopilotChat.
function M.ask_input()
  local input = vim.fn.input("Ask Copilot: ")
  if input ~= "" then
    vim.cmd("CopilotChat " .. input)
  end
end

return M
