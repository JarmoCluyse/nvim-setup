--- check if windows
IsWindows = vim.loop.os_uname().sysname:find("Windows") and true or false
