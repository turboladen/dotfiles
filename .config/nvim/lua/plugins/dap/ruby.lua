local Plugin         = { "suketa/nvim-dap-ruby" }

-- Plugin.enabled       = false
Plugin.event         = "VeryLazy"

local Config         = {}

Config.adapter       = function(callback, config)
  callback {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = { "exec", "rdbg", "-n", "--open", "--port", "${port}",
        "-c", "--", "bundle", "exec", config.command, config.script,
      },
    },
  }
end

Config.configuration = {
  {
    type = "ruby",
    name = "debug current file",
    request = "attach",
    localfs = true,
    command = "ruby",
    script = "${file}",
  },
  {
    type = "ruby",
    name = "run current spec file",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = "${file}",
  },
}

return {
  plugin = Plugin,
  config = Config,
}
