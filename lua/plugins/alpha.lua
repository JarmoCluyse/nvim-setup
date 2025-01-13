-- [[Alpha]] - minimalistic start screen
return {
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- neovim version
      local nvim_version = vim.version()
      local version_string = string.format("neovim version: v%d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch)
      if nvim_version.prerelease ~= nil then
        version_string = version_string .. "-" .. nvim_version.prerelease
      end
      if nvim_version.build ~= nil then
        version_string = version_string .. "+" .. nvim_version.build
      end
      -- current path as string
      local current_path = "current folder: " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~:.")
      -- current branch
      local branch = vim.fn.system("git branch --show-current")
      branch = string.gsub(branch, "\n", "")
      local branch_string = "current branch: " .. (branch == "" and "not a git repo" or branch)

      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        version_string,
        current_path,
        branch_string,
      }
      dashboard.section.buttons.val = {
        dashboard.button("<leader>sf", "󰈞  Find file"),
        dashboard.button("<leader>sa", "󰥨  Find folder"),
        dashboard.button("<leader>sg", "  Live grep"),
        dashboard.button("e", "  New file", "<cmd>ene<CR>"),
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
