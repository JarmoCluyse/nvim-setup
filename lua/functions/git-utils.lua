local M = {}

--- Get the top-level directory of a git repository.
--- @param dir string: The directory to check.
--- @return string: The top-level directory of the git repository, or an empty string if not in a git repository.
local function get_toplevel(dir)
  local is_windows = vim.loop.os_uname().sysname:find("Windows") and true or false
  local redirect = is_windows and "2>nul" or "2>/dev/null"
  local handle = io.popen("git -C " .. dir .. " rev-parse --show-toplevel " .. redirect)
  if not handle then
    return ""
  end
  local result = handle:read("*a"):gsub("\n", "")
  handle:close()
  return result
end

--- Get the git worktree of the current buffer.
--- @return string: The name of the git worktree.
function M.get_git_worktree()
  -- get the toplevel directory of the buffer
  local buffer_dir = vim.fn.expand("%:p:h")
  -- get the toplevel directory of the git repository
  local toplevel = get_toplevel(buffer_dir)
  if toplevel == "" then
    -- if the buffer is not in a git repository, return the worktree of the current nvim directory
    toplevel = get_toplevel(".")
  end

  return vim.fn.fnamemodify(toplevel, ":t")
end

return M
