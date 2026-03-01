-- NOTE: [[ Treesitter ]]
-- parse files for other plugins

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      -- Auto-install parser + enable highlighting and indentation for any filetype
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          local ts = require("nvim-treesitter")
          if lang and vim.tbl_contains(ts.get_available(), lang) then
            ts.install({ lang })
            pcall(vim.treesitter.start, ev.buf, lang)
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- Pre-install parsers for commonly used languages
      require("nvim-treesitter").install({
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "jsdoc",
        "typescript",
        "go",
      })
    end,
  },
}
