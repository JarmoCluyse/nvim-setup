local M = {}

local function get_solution_path()
  local solution = vim.g.roslyn_nvim_selected_solution
  if solution == nil then
    vim.notify("No solution selected", vim.log.levels.ERROR)
    return nil
  end
  local path = vim.fn.fnamemodify(solution, ":h")
  return path
end

local function get_projects(path)
  vim.cmd("cd " .. path)
  local projects = {}
  local job_id = vim.fn.jobstart("dotnet sln list", {
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line:match("%.csproj") then
          local project_name = vim.fn.fnamemodify(line, ":t:r")
          projects[project_name] = line
        end
      end
    end,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("dotnet sln list failed with exit code " .. code, vim.log.levels.ERROR)
      end
    end,
  })
  vim.fn.jobwait({ job_id })
  return projects
end

local function select_sync(items, opts)
  local co = assert(coroutine.running())
  vim.schedule(function()
    vim.ui.select(vim.tbl_keys(items), opts, function(selected) coroutine.resume(co, items[selected]) end)
  end)

  return coroutine.yield()
end

local function iselect_sync(items, opts)
  local co = assert(coroutine.running())
  vim.schedule(function()
    vim.ui.select(items, opts, function(selected) coroutine.resume(co, selected) end)
  end)

  return coroutine.yield()
end

local function readFileWithoutBom(file_name)
  local file = io.open(file_name, "rb")
  if file then
    local content = file:read("*all")
    file:close()
    -- Check if the content starts with the UTF-8 BOM and exclude it if present
    if content:sub(1, 3) == "\xEF\xBB\xBF" then
      content = content:sub(4)
    end
    return vim.json.decode(content)
  else
    return nil
  end
end

local function get_launch_profiles(project)
  local project_folder = vim.fn.fnamemodify(project, ":h")
  local file_name = project_folder .. "/Properties/launchSettings.json"
  local launch_settings = readFileWithoutBom(file_name)

  if launch_settings == nil then
    return {}
  end

  local profiles = {}
  for profile_name, profile in pairs(launch_settings.profiles) do
    if profile.commandName ~= "Project" then
      goto continue
    end

    profile.name = profile_name
    table.insert(profiles, profile)
    ::continue::
  end

  return profiles
end

local function select_launch_profile(project_folder)
  local launch_profiles = get_launch_profiles(project_folder)

  if #launch_profiles == 0 then
    return
  elseif #launch_profiles == 1 then
    return launch_profiles[1]
  end

  return iselect_sync(launch_profiles, {
    prompt = "Select Launch Profile:",
    format_item = function(item) return item.name end,
  })
end

--- @param options string[]?
local function dotnet_run(options)
  local command = "dotnet run"
  if options then
    command = command .. " " .. table.concat(options, " ")
  end

  local current_window = vim.api.nvim_get_current_win()
  vim.cmd("split | term " .. command)
  vim.api.nvim_set_current_win(current_window)
end

local function _start_program()
  local path = get_solution_path()
  if path == nil then
    return
  end
  local projects = get_projects(path)
  if vim.tbl_isempty(projects) then
    vim.notify("No projects found", vim.log.levels.ERROR)
    return
  end
  -- TODO: Select project
  local selected = select_sync(projects, {
    prompt = "Select project:",
  })
  -- get launch profiles
  local profile = select_launch_profile(selected)

  local opt = {
    "--project",
    selected,
    "-c",
    "Debug",
  }

  if profile then
    opt = vim.list_extend(opt, { "--launch-profile", profile.name })
  end

  dotnet_run(opt)
end

-- Register event handlers for DAP events to track what's happening
local function attach_dap_event_listeners(dap)
  dap.listeners.before["event_initialized"]["roslyn_debug"] = function(session, _)
    vim.notify("DAP Session initialized: " .. vim.inspect(session.id), vim.log.levels.INFO)
  end

  dap.listeners.before["event_terminated"]["roslyn_debug"] = function(_, body)
    vim.notify("DAP Session terminated: " .. vim.inspect(body), vim.log.levels.INFO)
  end

  dap.listeners.before["event_exited"]["roslyn_debug"] = function(_, body)
    vim.notify("DAP Process exited with code: " .. vim.inspect(body.exitCode), vim.log.levels.INFO)
  end

  dap.listeners.before["event_output"]["roslyn_debug"] = function(_, body)
    if body.category == "stderr" then
      vim.notify("DAP Error: " .. body.output, vim.log.levels.ERROR)
    end
  end

  dap.listeners.before["event_error"]["roslyn_debug"] = function(_, body)
    vim.notify("DAP Error event: " .. vim.inspect(body), vim.log.levels.ERROR)
  end
end

local function _debug_program()
  local path = get_solution_path()
  if path == nil then
    return
  end
  local projects = get_projects(path)
  if vim.tbl_isempty(projects) then
    vim.notify("No projects found", vim.log.levels.ERROR)
    return
  end

  local selected = select_sync(projects, {
    prompt = "Select project:",
  })

  -- get launch profiles
  local profile = select_launch_profile(selected)

  -- Use dap for debugging
  local dap = require("dap")

  local project_folder = vim.fn.fnamemodify(selected, ":h")
  local build_cmd = "dotnet build " .. selected .. " -c Debug"
  local build_result = vim.fn.system(build_cmd)
  vim.notify("Build result: " .. build_result, vim.log.levels.DEBUG)

  -- Find the compiled dll
  local dll_path
  local project_name = vim.fn.fnamemodify(selected, ":t:r")
  local dll_pattern = project_folder .. "/bin/Debug/*/" .. project_name .. ".dll"
  local dll_files = vim.fn.glob(dll_pattern)

  if dll_files ~= "" then
    local dll_files_table = vim.split(dll_files, "\n")
    dll_path = dll_files_table[1]

    -- Check if the file actually exists
    if vim.fn.filereadable(dll_path) == 1 then
    else
      vim.notify("DLL path is not readable: " .. dll_path, vim.log.levels.ERROR)
      return nil
    end
  else
    vim.notify("Could not find compiled DLL for " .. project_name, vim.log.levels.ERROR)
    return nil
  end

  local configuration = {
    type = "coreclr",
    name = "Debug .NET Core Launch",
    request = "launch",
    program = vim.fn.fnamemodify(dll_path, ":t"),
    cwd = vim.fn.fnamemodify(dll_path, ":h"),
    console = "integratedTerminal",
    justMyCode = false, -- Try debugging with .NET source code included
  }

  -- Add launch profile settings if available
  if profile then
    vim.notify("Using launch profile: " .. profile.name, vim.log.levels.INFO)
    if profile.applicationUrl then
      configuration.env = configuration.env or {}
      configuration.env.ASPNETCORE_URLS = profile.applicationUrl
    end
    -- Add any environment variables from the profile
    if profile.environmentVariables then
      configuration.env = configuration.env or {}
      for key, value in pairs(profile.environmentVariables) do
        configuration.env[key] = value
      end
    end
  end

  attach_dap_event_listeners(dap)

  -- Start debugging with error handling
  vim.notify("Starting DAP debugger session now...", vim.log.levels.INFO)
  local status, err = pcall(function() dap.run(configuration) end)

  if not status then
    vim.notify("Error running debugger: " .. vim.inspect(err), vim.log.levels.ERROR)
  end
end

function M.start_program()
  local co = coroutine.create(_start_program)
  local success = coroutine.resume(co)
  if not success then
    vim.notify("Error has occurred!", vim.log.levels.ERROR)
  end
end

function M.debug_program()
  local co = coroutine.create(_debug_program)
  local success = coroutine.resume(co)
  if not success then
    vim.notify("Error has occurred!", vim.log.levels.ERROR)
  end
end

function M.setup()
  vim.api.nvim_create_user_command("RoslynUtils", function(opts)
    local subcmd = opts.args
    if subcmd == "start" then
      M.start_program()
    elseif subcmd == "debug" then
      M.debug_program()
    else
      vim.notify("Unknown RoslynUtils subcommand: " .. subcmd, vim.log.levels.ERROR)
    end
  end, {
    nargs = 1,
    complete = function(_, _, _) return { "start", "debug" } end,
    desc = "RoslynUtils commands",
  })

  vim.keymap.set("n", "<leader>ne", M.start_program, { desc = "Start dotnet project" })
  vim.keymap.set("n", "<leader>nd", M.debug_program, { desc = "Debug dotnet project" })
end

return M
