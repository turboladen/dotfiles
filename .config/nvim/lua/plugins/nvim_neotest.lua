-- ╭───────────────────────────────────────────────────────────────────╮
-- │ An extensible framework for interacting with tests within NeoVim. │
-- ╰───────────────────────────────────────────────────────────────────╯
-- Maps borrowed from https://www.lazyvim.org/extras/test/core.
--
local Plugin = { "nvim-neotest/neotest" }

Plugin.event = "VeryLazy"

Plugin.dependencies = {
  "antoinemadec/FixCursorHold.nvim",
  "nvim-lua/plenary.nvim",
  require("plugins.nvim_treesitter"),
  "olimorris/neotest-rspec",
  require("plugins.nvim_lspconfig.rustaceanvim"),
  require("plugins.neodev_nvim"),
}

Plugin.opts = function()
  return {
    adapters = {
      require('neotest-rspec'),
      require('rustaceanvim.neotest'),
    },
    output = {
      enabled = false
    },
    output_panel = {
      open = "botright split | resize | clear"
    },
  }
end

local TestCmds = {}
--- Run the nearest test.
TestCmds.nearest = function()
  require("neotest").summary.toggle()
  require("neotest").run.run()
end

--- Run the nearest test.
TestCmds.watch_nearest = function()
  require("neotest").summary.toggle()
  require("neotest").watch()
end

--- Run all tests in the current file.
TestCmds.file = function()
  require("neotest").summary.toggle()
  require("neotest").run.run(vim.fn.expand("%"))
end

TestCmds.watch_file = function()
  require("neotest").summary.toggle()
  require("neotest").watch(vim.fn.expand("%"))
end

--- Run all tests in all files.
TestCmds.all = function()
  require("neotest").summary.toggle()
  require("neotest").run.run(vim.loop.cwd())
end

--- Watch all tests in all files.
TestCmds.watch_all = function()
  require("neotest").summary.toggle()
  require("neotest").watch(vim.loop.cwd())
end

-- local DebugCmds = {}

-- --- Debug the nearest test. Requires DAP setup.
-- DebugCmds.nearest = function()
--   require("neotest").run.run({ strategy = 'dap' })
-- end

--- Toggle showing test output.
Plugin.toggle_output = function()
  require("neotest").output.open({ enter = true, auto_close = true })
end

--- Jump to next failed test.
Plugin.next_failed = function()
  require("neotest").jump.next({ status = "failed" })
end

--- Jump to previous failed test.
Plugin.prev_failed = function()
  require("neotest").jump.prev({ status = "failed" })
end

Plugin.test_cmds = TestCmds
-- Plugin.debug_cmds = DebugCmds

return Plugin
