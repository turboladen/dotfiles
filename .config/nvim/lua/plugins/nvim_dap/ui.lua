-- ╭───────────────────╮
-- │ A UI for nvim-dap │
-- ╰───────────────────╯
local Plugin = { "rcarriga/nvim-dap-ui" }

Plugin.enabled = false
Plugin.event = "VeryLazy"
Plugin.opts = {}

Plugin.config = function(_, opts)
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup(opts)

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end
end

return Plugin
