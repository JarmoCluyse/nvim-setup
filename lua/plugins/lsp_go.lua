-- NOTE: [[ go ]]
-- lsp for go

-- cspell:ignore gopls guihua didchangeconfiguration workspacedidchangeconfiguration

-- Whether the "extra" gopls inlay hints (parameterNames, compositeLiteralFields)
-- are currently enabled. Toggled with <leader>ui. Persists for the session.
local extra_hints_enabled = false

-- Flip the "extra" gopls hint categories on/off for all attached gopls clients
-- and notify the server so it applies live (no LSP restart needed).
local function toggle_extra_go_hints()
  extra_hints_enabled = not extra_hints_enabled

  local clients = vim.lsp.get_clients({ name = "gopls", bufnr = 0 })
  for _, client in ipairs(clients) do
    local settings = client.settings
    if settings and settings.gopls and settings.gopls.hints then
      settings.gopls.hints.parameterNames = extra_hints_enabled
      settings.gopls.hints.compositeLiteralFields = extra_hints_enabled
      client.notify("workspace/didChangeConfiguration", { settings = settings })
    end
  end

  vim.notify(
    "Go extra inlay hints (parameter names / composite literal fields): " .. (extra_hints_enabled and "on" or "off"),
    vim.log.levels.INFO
  )
end

return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      lsp_cfg = {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = false, -- redundant with K hover
              compositeLiteralFields = extra_hints_enabled, -- toggleable via <leader>ui
              compositeLiteralTypes = false, -- redundant with K hover
              constantValues = true,
              functionTypeParameters = false, -- redundant with K hover
              ignoredError = true,
              parameterNames = extra_hints_enabled, -- toggleable via <leader>ui
              rangeVariableTypes = true,
            },
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
      group = vim.api.nvim_create_augroup("go-extra-inlay-hints", { clear = true }),
      callback = function(event)
        vim.keymap.set(
          "n",
          "<leader>ui",
          toggle_extra_go_hints,
          { buffer = event.buf, desc = "Toggle extra Go [I]nlay hints (parameter names / composite literal fields)" }
        )
      end,
    })
  end,
  lazy = true,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
