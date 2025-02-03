-- NOTE: [[ Filetypes ]]
-- set filetypes for specific file extensions / patterns

-- TODO: Bash may not be the best filetype for .env files

vim.filetype.add({
  -- Detect and assign filetype based on the extension of the filename
  extension = {
    mdx = "mdx",
    log = "log",
    conf = "conf",
    env = "bash",
  },
  -- Detect and apply filetypes based on the entire filename
  filename = {
    [".env"] = "bash",
    ["env"] = "bash",
  },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "bash",
    -- ["tsconfig%.[%w_.-]%.json"] = "jsonc",
  },
})
