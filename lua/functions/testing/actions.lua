local M = {}

--- Runs the test at the cursor.
function M.test_cursor() require("neotest").run.run() end

--- Runs the test in the current file.
function M.test_file() require("neotest").run.run(vim.fn.expand("%")) end

--- Debugs the test at the cursor.
function M.debug_cursor() require("neotest").run.run({ strategy = "dap", suite = false }) end

--- Debugs the test in the current file.
function M.debug_file() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", suite = false }) end

--- run all tests
function M.run_all() require("neotest").run.run({ vim.fn.expand("%"), suite = true }) end

return M
