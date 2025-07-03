local M = {}

-- Utility functions
local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

local function is_likely_external_tool(name)
  -- Heuristics to determine if a name looks like an external tool
  return name:match("^[a-z][a-z0-9_%-]*$") -- lowercase with dashes/underscores
    and not name:match("nvim") -- not nvim-related
    and not name:match("^vim") -- not vim-related
    and not name:match("%.lua$") -- not lua files
    and not name:match("^%u") -- not constants/enums
    and string.len(name) > 2 -- reasonable length
end

-- Parse dependency comments from files
local function parse_dependency_comments(content)
  local deps = {}
  local in_deps_section = false

  for line in content:gmatch("[^\r\n]+") do
    if line:match("^%-%- Dependencies to install:") then
      in_deps_section = true
    elseif in_deps_section and line:match("^%-%-") then
      local comment = trim(line:gsub("^%-%- ?", ""))
      if comment ~= "" and not comment:match("^Note:") then
        -- Try to extract tool name and install command
        local tool, install_cmd = comment:match("^([^:]+):%s*(.+)$")
        if tool and install_cmd then
          deps[trim(tool)] = {
            source = "comment",
            install_cmd = trim(install_cmd),
            type = "manual",
          }
        else
          -- Store the whole comment if we can't parse it
          deps[#deps + 1] = comment
        end
      end
    elseif in_deps_section and not line:match("^%-%-") and not line:match("^%s*$") then
      in_deps_section = false
    end
  end

  return deps
end

-- Extract LSP server names from code
local function extract_lsp_servers(content)
  local servers = {}

  -- Pattern: vim.lsp.config("server_name", ...)
  for server in content:gmatch('vim%.lsp%.config%("([^"]+)"') do
    if server ~= "*" and is_likely_external_tool(server) then
      servers[server] = {
        source = "vim.lsp.config",
        type = "lsp",
        pattern = "vim.lsp.config",
      }
    end
  end

  -- Pattern: vim.lsp.enable("server_name")
  for server in content:gmatch('vim%.lsp%.enable%("([^"]+)"%)') do
    if is_likely_external_tool(server) then
      servers[server] = {
        source = "vim.lsp.enable",
        type = "lsp",
        pattern = "vim.lsp.enable",
      }
    end
  end

  -- Pattern: lspconfig.server_name.setup
  for server in content:gmatch("lspconfig%.([%w_]+)%.setup") do
    if is_likely_external_tool(server) then
      servers[server] = {
        source = "lspconfig.setup",
        type = "lsp",
        pattern = "lspconfig.*.setup",
      }
    end
  end

  return servers
end

-- Extract formatters from conform.nvim config
local function extract_formatters(content)
  local formatters = {}

  -- Look for formatters_by_ft table entries
  local in_formatters_table = false
  for line in content:gmatch("[^\r\n]+") do
    if line:match("formatters_by_ft%s*=") then
      in_formatters_table = true
    elseif in_formatters_table and line:match("^%s*}") then
      in_formatters_table = false
    elseif in_formatters_table then
      -- Extract formatter names from arrays: lua = { "stylua" }
      for formatter in line:gmatch('"([^"]+)"') do
        if is_likely_external_tool(formatter) then
          formatters[formatter] = {
            source = "formatters_by_ft",
            type = "formatter",
            pattern = "formatters_by_ft table",
          }
        end
      end
    end
  end

  return formatters
end

-- Extract linters from nvim-lint config
local function extract_linters(content)
  local linters = {}

  -- Look for linters_by_ft table entries
  local in_linters_table = false
  for line in content:gmatch("[^\r\n]+") do
    if line:match("linters_by_ft%s*=") then
      in_linters_table = true
    elseif in_linters_table and line:match("^%s*}") then
      in_linters_table = false
    elseif in_linters_table then
      -- Extract linter names from arrays
      for linter in line:gmatch('"([^"]+)"') do
        if is_likely_external_tool(linter) then
          linters[linter] = {
            source = "linters_by_ft",
            type = "linter",
            pattern = "linters_by_ft table",
          }
        end
      end
    end
  end

  return linters
end

-- Check if a tool is installed on the system (async version)
local function check_tool_installed_async(tool_name, callback)
  local status = {
    installed = false,
    version = nil,
    path = nil,
  }

  -- Try 'which' command first
  vim.system({ "which", tool_name }, { text = true }, function(result)
    if result.code == 0 and result.stdout and result.stdout:len() > 0 then
      status.installed = true
      status.path = trim(result.stdout)

      -- Try to get version
      vim.system({ tool_name, "--version" }, { text = true }, function(version_result)
        if version_result.code == 0 and version_result.stdout then
          -- Extract first line which usually contains version
          status.version = trim(version_result.stdout:match("[^\r\n]+") or "")
        end
        callback(status)
      end)
    else
      callback(status)
    end
  end)
end

-- Check if a tool is installed on the system (sync version for backwards compatibility)
local function check_tool_installed(tool_name)
  local status = {
    installed = false,
    version = nil,
    path = nil,
  }

  -- Try 'which' command first
  local which_result = vim.fn.system("which " .. tool_name .. " 2>/dev/null")
  if vim.v.shell_error == 0 and which_result:len() > 0 then
    status.installed = true
    status.path = trim(which_result)

    -- Try to get version
    local version_result = vim.fn.system(tool_name .. " --version 2>/dev/null")
    if vim.v.shell_error == 0 then
      -- Extract first line which usually contains version
      status.version = trim(version_result:match("[^\r\n]+") or "")
    end
  end

  return status
end

-- Get all relevant configuration files
local function get_config_files()
  local files = {}
  local search_paths = {
    vim.fn.stdpath("config") .. "/lua/plugins/lang",
    vim.fn.stdpath("config") .. "/lua/plugins/extras/lang",
    vim.fn.stdpath("config") .. "/lua/plugins/formatting.lua",
    vim.fn.stdpath("config") .. "/lua/plugins/linting.lua",
    vim.fn.stdpath("config") .. "/lua/plugins/lsp.lua",
  }

  for _, search_path in ipairs(search_paths) do
    if vim.fn.isdirectory(search_path) == 1 then
      -- Directory - get all .lua files
      local lang_files = vim.fn.glob(search_path .. "/*.lua", false, true)
      for _, file in ipairs(lang_files) do
        table.insert(files, {
          path = file,
          name = vim.fn.fnamemodify(file, ":t:r"),
          type = "lang",
        })
      end
    elseif vim.fn.filereadable(search_path) == 1 then
      -- Single file
      table.insert(files, {
        path = search_path,
        name = vim.fn.fnamemodify(search_path, ":t:r"),
        type = "config",
      })
    end
  end

  return files
end

-- Main analysis function (async version)
function M.analyze_async(callback)
  local results = {
    by_file = {},
    all_tools = {},
    summary = {
      total_tools = 0,
      installed = 0,
      missing = 0,
      by_type = {},
    },
  }

  local config_files = get_config_files()

  -- First pass: collect all tools without checking installation status
  for _, file_info in ipairs(config_files) do
    if vim.fn.filereadable(file_info.path) == 1 then
      local content = table.concat(vim.fn.readfile(file_info.path), "\n")

      local file_deps = {
        comments = parse_dependency_comments(content),
        lsp_servers = extract_lsp_servers(content),
        formatters = extract_formatters(content),
        linters = extract_linters(content),
      }

      results.by_file[file_info.name] = file_deps

      -- Collect all tools
      for category, tools in pairs(file_deps) do
        if type(tools) == "table" and category ~= "comments" then
          for tool_name, tool_info in pairs(tools) do
            if not results.all_tools[tool_name] then
              results.all_tools[tool_name] = {
                info = tool_info,
                found_in = { file_info.name },
                install_status = { installed = false, version = nil, path = nil },
              }
            else
              table.insert(results.all_tools[tool_name].found_in, file_info.name)
            end
          end
        end
      end
    end
  end

  -- Second pass: check installation status asynchronously
  local tool_names = vim.tbl_keys(results.all_tools)
  local completed_checks = 0
  local total_checks = #tool_names

  if total_checks == 0 then
    callback(results)
    return
  end

  for _, tool_name in ipairs(tool_names) do
    check_tool_installed_async(tool_name, function(status)
      results.all_tools[tool_name].install_status = status
      completed_checks = completed_checks + 1

      if completed_checks >= total_checks then
        -- Calculate summary statistics
        results.summary.total_tools = vim.tbl_count(results.all_tools)

        for _, tool_data in pairs(results.all_tools) do
          if tool_data.install_status.installed then
            results.summary.installed = results.summary.installed + 1
          else
            results.summary.missing = results.summary.missing + 1
          end

          local tool_type = tool_data.info.type or "unknown"
          results.summary.by_type[tool_type] = (results.summary.by_type[tool_type] or 0) + 1
        end

        callback(results)
      end
    end)
  end
end

-- Main analysis function (sync version for backwards compatibility)
function M.analyze()
  local results = {
    by_file = {},
    all_tools = {},
    summary = {
      total_tools = 0,
      installed = 0,
      missing = 0,
      by_type = {},
    },
  }

  local config_files = get_config_files()

  for _, file_info in ipairs(config_files) do
    if vim.fn.filereadable(file_info.path) == 1 then
      local content = table.concat(vim.fn.readfile(file_info.path), "\n")

      local file_deps = {
        comments = parse_dependency_comments(content),
        lsp_servers = extract_lsp_servers(content),
        formatters = extract_formatters(content),
        linters = extract_linters(content),
      }

      results.by_file[file_info.name] = file_deps

      -- Collect all tools
      for category, tools in pairs(file_deps) do
        if type(tools) == "table" and category ~= "comments" then
          for tool_name, tool_info in pairs(tools) do
            if not results.all_tools[tool_name] then
              results.all_tools[tool_name] = {
                info = tool_info,
                found_in = { file_info.name },
                install_status = check_tool_installed(tool_name),
              }
            else
              table.insert(results.all_tools[tool_name].found_in, file_info.name)
            end
          end
        end
      end
    end
  end

  -- Calculate summary statistics
  results.summary.total_tools = vim.tbl_count(results.all_tools)

  for tool_name, tool_data in pairs(results.all_tools) do
    if tool_data.install_status.installed then
      results.summary.installed = results.summary.installed + 1
    else
      results.summary.missing = results.summary.missing + 1
    end

    local tool_type = tool_data.info.type or "unknown"
    results.summary.by_type[tool_type] = (results.summary.by_type[tool_type] or 0) + 1
  end

  return results
end

-- Export the raw data for programmatic use
function M.get_data()
  return M.analyze()
end

-- Get just missing tools (most common use case)
function M.get_missing_tools()
  local results = M.analyze()
  local missing = {}

  for tool_name, tool_data in pairs(results.all_tools) do
    if not tool_data.install_status.installed then
      table.insert(missing, {
        name = tool_name,
        type = tool_data.info.type,
        source = tool_data.info.source,
        found_in = tool_data.found_in,
        install_cmd = nil, -- Will be populated from comments if available
      })
    end
  end

  -- Add install commands from comments
  for _, tool in ipairs(missing) do
    for file_name, file_data in pairs(results.by_file) do
      if file_data.comments[tool.name] and file_data.comments[tool.name].install_cmd then
        tool.install_cmd = file_data.comments[tool.name].install_cmd
        break
      end
    end
  end

  return missing
end

-- Get installed tools with version info
function M.get_installed_tools()
  local results = M.analyze()
  local installed = {}

  for tool_name, tool_data in pairs(results.all_tools) do
    if tool_data.install_status.installed then
      table.insert(installed, {
        name = tool_name,
        type = tool_data.info.type,
        version = tool_data.install_status.version,
        path = tool_data.install_status.path,
        found_in = tool_data.found_in,
      })
    end
  end

  return installed
end

-- Get summary statistics
function M.get_summary()
  local results = M.analyze()
  return {
    total_tools = results.summary.total_tools,
    installed = results.summary.installed,
    missing = results.summary.missing,
    by_type = results.summary.by_type,
    has_missing = results.summary.missing > 0,
  }
end

-- Setup function (minimal, no setup needed - commands handled in plugin config)
function M.setup()
  -- No setup needed - this follows the same pattern as keymap-analyzer
end

return M
