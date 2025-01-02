local neotest = require("neotest")

neotest.setup({
    adapters = {
      -- require('neotest-rust'),
      require('rustaceanvim.neotest'),
    },
    -- output = {
    --   enabled = false
    -- },
    output_panel = {
      open = "botright split | resize | clear"
    },
})

local TestCmds = {}
--- Run the nearest test.
TestCmds.nearest = function()
  neotest.summary.open()
  neotest.run.run()
end

--- Run the nearest test.
TestCmds.watch_nearest = function()
  neotest.summary.open()
  neotest.watch()
end

--- Run all tests in the current file.
TestCmds.file = function()
  neotest.summary.open()
  neotest.run.run(vim.fn.expand("%"))
end

TestCmds.watch_file = function()
  neotest.summary.open()
  neotest.watch(vim.fn.expand("%"))
end

--- Run all tests in all files.
TestCmds.all = function()
  neotest.summary.open()
  neotest.run.run(vim.loop.cwd())
end

--- Watch all tests in all files.
TestCmds.watch_all = function()
  neotest.summary.toggle()
  neotest.watch(vim.loop.cwd())
end

local M = {}

M.toggle_output_panel = function()
  require("neotest").output_panel.toggle()

  -- Resize the windows since neotest's window takes up the whole view
  local resize = vim.api.nvim_replace_termcodes('<C-w>=', true, false, true)
  vim.api.nvim_input(resize)
end

--- Jump to next failed test.
M.next_failed = function()
  require("neotest").jump.next({ status = "failed" })
end

--- Jump to previous failed test.
M.prev_failed = function()
  require("neotest").jump.prev({ status = "failed" })
end

M.test_cmds = TestCmds

return M
