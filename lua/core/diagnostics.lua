-- [[ Diagnostic Configuration ]]

vim.diagnostic.config({

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  underline = {
    severity = vim.diagnostic.severity.INFO,
  },
  float = {
    border = "single",
  },
  virtual_text = true,
})
