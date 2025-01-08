-- [[Alpha]] - minimalistic start screen
return {
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", "<cmd>ene<CR>"),
        dashboard.button("<leader>sf", "󰈞  Find file"),
        dashboard.button("<leader>sa", "󰥨  Find folder"),
        dashboard.button("<leader>sg", "  Live grep"),
        dashboard.button("c", "  Configuration", "<cmd>cd stdpath('config')<CR>"),
        dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
        dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
      }
      local handle = io.popen("fortune")
      local fortune = handle:read("*a")
      handle:close()
      dashboard.section.footer.val = fortune
      dashboard.config.opts.noautocmd = true

      vim.cmd([[autocmd User AlphaReady echo 'ready']])

      alpha.setup(dashboard.config)
    end,
  },
}
