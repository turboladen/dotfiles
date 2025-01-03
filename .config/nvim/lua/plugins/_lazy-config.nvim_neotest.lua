-- ╭───────────────────────────────────────────────────────────────────╮
-- │ An extensible framework for interacting with tests within NeoVim. │
-- ╰───────────────────────────────────────────────────────────────────╯
-- Maps borrowed from https://www.lazyvim.org/extras/test/core.
--
local Plugin = { "nvim-neotest/neotest" }

Plugin.event = "VeryLazy"

Plugin.dependencies = {
  "nvim-neotest/nvim-nio",
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "nvim-treesitter/nvim-treesitter",
  -- require("plugins.nvim_treesitter"),
  "olimorris/neotest-rspec",
  -- require("plugins.nvim_lspconfig.rustaceanvim"),
  "rouge8/neotest-rust", -- rustacean.neotest doesn't pick up tests most of the time
  require("plugins.neodev_nvim"),
  -- "rouge8/neotest-rust"
}

Plugin.opts = function()
  return {
    adapters = {
      -- require('neotest-rspec'),
      -- require('neotest-rust'),
      -- require('rustaceanvim.neotest'),
    },
    -- output = {
    --   enabled = false
    -- },
    output_panel = {
      open = "botright split | resize | clear"
    },
  }
end

local TestCmds = {}
--- Run the nearest test.
TestCmds.nearest = function()
  require("neotest").summary.open()
  require("neotest").run.run()
end

--- Run the nearest test.
TestCmds.watch_nearest = function()
  require("neotest").summary.open()
  require("neotest").watch()
end

--- Run all tests in the current file.
TestCmds.file = function()
  require("neotest").summary.open()
  require("neotest").run.run(vim.fn.expand("%"))
end

TestCmds.watch_file = function()
  require("neotest").summary.open()
  require("neotest").watch(vim.fn.expand("%"))
end

--- Run all tests in all files.
TestCmds.all = function()
  require("neotest").summary.open()
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

Plugin.toggle_output_panel = function()
  require("neotest").output_panel.toggle()

  -- Resize the windows since neotest's window takes up the whole view
  local resize = vim.api.nvim_replace_termcodes('<C-w>=', true, false, true)
  vim.api.nvim_input(resize)
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
