local Job = require("plenary.job")

local function missing_commands(...)
  local command_names = { ... }
  print("Checking for " .. vim.inspect(command_names))

  local needs_install = {}
  local jobs = {}

  for _, command_name in pairs(command_names) do
    table.insert(jobs, Job:new({
      command = "type",
      args = { command_name },
      on_exit = function(_, return_val)
        if return_val ~= 0 then
          table.insert(needs_install, command_name)
        end
      end
    }))
  end

  -- print(vim.inspect(jobs))
  Job.chain(jobs)
  -- Job.join(jobs)
  print(vim.inspect(needs_install))

  return needs_install
end

local pip_install = function(package_name)
  print("Checking for " .. package_name)

  Job:new(
    {
      command = "type",
      args = { package_name },
      on_exit = function(_, return_val)
        if return_val ~= 0 then
          Job:new(
            {
              command = "pip",
              args = { "install", package_name },
              on_exit = function(_, r)
                if r ~= 0 then
                  print("plugins.lua: " .. package_name .. " install failed!")
                else
                  print("plugins.lua: " .. package_name .. " installed.")
                end
              end
            }
          ):sync()
        end
      end
    }
  ):start()
end

local npm_install = function(package_name)
  print("Checking for " .. package_name)

  Job:new(
    {
      command = "type",
      args = { package_name },
      on_exit = function(_, return_val)
        if return_val ~= 0 then
          Job:new(
            {
              command = "npm",
              args = { "install", "-g", package_name },
              on_exit = function(_, r)
                if r ~= 0 then
                  print("plugins.lua: " .. package_name .. " install failed!")
                else
                  print("plugins.lua: " .. package_name .. " installed.")
                end
              end
            }
          ):sync()
        end
      end
    }
  ):start()
end


local brew_install = function(...)
  local package_names = { ... }
  local needs_install = missing_commands(...)

  if vim.tbl_isempty(needs_install) then
    return
  end

  local args = { "install" }
  vim.list_extend(args, needs_install)
  print(vim.inspect(args))

  Job:new(
    {
      command = "brew",
      args = args,
      enabled_recording = true,
      on_exit = function(j, r)
        if r ~= 0 then
          print("plugins.lua: " .. vim.inspect(package_names) .. " install failed!")
          print("plugins.lua: " .. vim.inspect(j:result()))
          -- print("plugins.lua: " .. vim.inspect(j:stderr_result()))
        else
          print("plugins.lua: " .. vim.inspect(package_names) .. " installed.")
        end
      end
    }
  ):sync(50000)
end

local gem_install = function(package_name)
  print("Checking for " .. package_name)

  Job:new(
    {
      command = "gem",
      args = { "install", package_name },
      on_exit = function(_, r)
        if r ~= 0 then
          print("plugins.lua: " .. package_name .. " install failed!")
        else
          print("plugins.lua: " .. package_name .. " installed.")
        end
      end
    }
  ):start()
end

local luarocks_install = function(package_name)
  print("[luarocks_install] Checking for " .. package_name)
  local needs_install = missing_commands(package_name)

  if vim.tbl_isempty(needs_install) then
    print("[luarocks_install] Nothing needs installation.")
    return
  end

  local args = { "install" }
  vim.list_extend(args, needs_install)
  print(vim.inspect(args))

  Job:new(
    {
      command = "luarocks",
      args = args,
      on_exit = function(_, r)
        if r ~= 0 then
          print("plugins.lua: " .. package_name .. " install failed!")
        else
          print("plugins.lua: " .. package_name .. " installed.")
        end
      end
    }
  ):start()
end

return {
  brew_install = brew_install,
  gem_install = gem_install,
  npm_install = npm_install,
  pip_install = pip_install,
  luarocks_install = luarocks_install
}
