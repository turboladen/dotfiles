-- ╭───────────────────────────────────────────────────────────────────╮
-- │ An extensible framework for interacting with tests within NeoVim. │
-- ╰───────────────────────────────────────────────────────────────────╯
local function test_nearest()
  local neotest = require('neotest')

  neotest.run.run()
  neotest.output_panel.open()
end

local function debug_nearest()
  local neotest = require('neotest')

  neotest.run.run({ strategy = 'dap' })

  neotest.output.open({ enter = true })
  neotest.summary.open()
end

local function test_current_file()
  local neotest = require('neotest')

  neotest.run.run(vim.fn.expand("%"))

  neotest.output_panel.open()
  neotest.summary.open()
end

return {
  "nvim-neotest/neotest",
  lazy = true,
  enabled = false,
  dependencies = {
    "antoinemadec/FixCursorHold.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
    "rouge8/neotest-rust"
  },
  opts = function()
    return {
      adapters = {
        require('neotest-rspec'),
        require("neotest-rust")
      },
      output = {
        enabled = false
      },
      output_panel = {
        open = "botright split | resize | clear"
      },
    }
  end,
  keys = {
    {
      "<leader>tn", test_nearest, desc = "Run the nearest test"
    },
    {
      "<leader>td", debug_nearest, desc = "Debug the nearest test" },
    {
      "<leader>tf", test_current_file, desc = "Test the current file" },
    {
      "<leader>tt", function() require("neotest").output.open({ enter = true }) end, desc = "Toggle test output pane"
    },
    {
      "<leader>to",
      function() require("neotest").output_panel.open({ enter = true }) end,
      desc = "Toggle test output panel"
    },
    {
      "[n",
      function() require("neotest").jump.prev({ status = "failed" }) end,
      desc = "Jump: previous failed test"
    },
    {
      "[n",
      function() require("neotest").jump.next({ status = "failed" }) end,
      desc = "Jump: next failed test"
    },
  },
  -- config = function(_, opts)
  --   local neotest = require("neotest")
  --   neotest.setup(opts)
  --   vim.keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<CR>")
  -- end
}
