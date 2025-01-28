-- NOTE: [[]]

-- cspell:ignore lazydev luvit dependants lsp lspconfig folke lazydev autocmd autocmds augroup

return {
  {
    "folke/lazydev.nvim",
    lazy = true,
    event = "VeryLazy",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- NOTE: Type definitions for Lua Language
    "Bilal2453/luvit-meta", -- cspell:disable-line
    lazy = true,
    event = "VeryLazy",
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants -- cspell:disable-line
      "williamboman/mason-lspconfig.nvim", -- cspell:disable-line
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- cspell:disable-line
      { "j-hui/fidget.nvim", opts = {} }, -- cspell:disable-line
      -- NOTE: Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp", -- cspell:disable-line
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local builtin = require("telescope.builtin")

          map("gd", builtin.lsp_definitions, "[G]oto [D]definition") -- cspell:disable-line
          map("gr", builtin.lsp_references, "[G]oto [R]eferences") -- cspell:disable-line-- cspell:disable-line-- cspell:disable-line-- cspell:disable-line
          map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation") -- cspell:disable-line
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration") -- cspell:disable-line
          map("gk", builtin.lsp_type_definitions, "[G]oto [K]type definition") -- cspell:disable-line
          map("<leader>kw", builtin.lsp_dynamic_workspace_symbols, "[k]symbols [W]workspace") -- cspell:disable-line
          map("<leader>kd", builtin.lsp_document_symbols, "[k]symbols  [D]document") -- cspell:disable-line
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame") -- cspell:disable-line
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" }) -- cspell:disable-line

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false }) -- cspell:disable-line
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) -- cspell:disable-line
            end, "[T]oggle Inlay [H]ints") -- cspell:disable-line
          end
        end,
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        powershell_es = {
          filetypes = { "ps1", "psm1", "psd1" },
          bundle_path = "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services",
          settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
          init_options = {
            enableProfileLoading = false,
          },
        },
        omnisharp = {
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
            },
            RoslynExtensionsOptions = {
              -- Enables support for roslyn analyzers, code fixes and rulesets.
              EnableAnalyzersSupport = true,
              EnableImportCompletion = true,
              AnalyzeOpenDocumentsOnly = nil,
            },
            Sdk = {
              IncludePrereleases = true,
            },
          },
        },
      }

      require("mason").setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
        "eslint_d",
        "prettier",
        "eslint",
        "cspell",
        "codespell",
        "gopls",
        "delve",
        "omnisharp",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
