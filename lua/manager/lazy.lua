-- NOTE: Lazy plugins manager

--- Path to the lazy.nvim plugin.
local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

--- Check if the lazy.nvim plugin is installed, if not, clone it from the repository.
if not (vim.uv or vim.loop).fs_stat(lazyPath) then
  local lazyRepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyRepo, lazyPath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

--- Prepend the lazy.nvim plugin path to the runtime path.
vim.opt.rtp:prepend(lazyPath)

--- Setup the lazy.nvim plugin with the specified configuration.
require("lazy").setup("plugins", {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
