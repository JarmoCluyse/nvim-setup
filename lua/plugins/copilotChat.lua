-- NOTE: [[ Copilot chat ]]

-- cspell:ignore errmsg

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    event = "VeryLazy",
    build = "make tiktoken", -- Only on MacOS or Linu
    keys = {
      { "<leader>ah", require("functions.copilot.actions").help_actions, desc = "CopilotChat - Help actions" },
      { "<leader>ap", require("functions.copilot.actions").prompt_actions, desc = "CopilotChat - Prompt actions" },
      { "<leader>ap", require("functions.copilot.actions").prompt_actions_visual, mode = "x", desc = "CopilotChat - Prompt actions" },
      -- Code related commands
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat with Copilot in visual mode
      { "<leader>av", ":CopilotChatVisual", mode = "x", desc = "CopilotChat - Open in vertical split" },
      { "<leader>ax", ":CopilotChatInline<cr>", mode = "x", desc = "CopilotChat - Inline chat" },
      -- Custom input for CopilotChat
      { "<leader>ai", require("functions.copilot.actions").ask_input, desc = "CopilotChat - Ask input" },
      -- Generate commit message based on the git diff
      { "<leader>am", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate commit message for all changes" },
      { "<leader>aM", "<cmd>CopilotChatCommitStaged<cr>", desc = "CopilotChat - Generate commit message for staged changes" },
      -- Quick chat with Copilot
      { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
      { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
    },
    config = function()
      local prompts = require("functions.copilot.prompts").prompts

      require("CopilotChat").setup({
        prompts = prompts,
        allow_insecure = true, -- Allow insecure connection_failure_errmsg
        chat_autocomplete = true,
      })
    end,
  },
}
