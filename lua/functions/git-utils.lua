local M = {}

-- Get the toplevel directory of a git repository
-- @param dir The directory to get the toplevel of
-- @return The toplevel directory of the git repository
local function get_toplevel(dir)
  local handle = io.popen("git -C " .. dir .. " rev-parse --show-toplevel 2>nul")
  if not handle then
    return ""
  end
  local result = handle:read("*a"):gsub("\n", "")
  handle:close()
  return result
end

-- Get the current git worktree of the buffer
-- if the buffer is not in a git repository, return the worktree of the current nvim directory
-- else return nothing
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
