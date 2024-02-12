-- ╭─────────────────────────────────────────────────────────╮
-- │ Debug Adapter Protocol client implementation for Neovim │
-- ╰─────────────────────────────────────────────────────────╯
-- NOTES!
-- 1. To debug rust stuff, I'm using rust-tools setup... which means, I need to run :RustDebuggables
--    instead of pressing F5.
local Plugin = { "mfussenegger/nvim-dap" }

Plugin.event = "VeryLazy"

Plugin.dependencies = {
  "nvim-lua/plenary.nvim",

  -- require("plugins.dap.ui"),
  -- require("plugins.dap.virtual-text"),
  -- require("plugins.dap.ruby").plugin,
  -- require("plugins.dap.mason-nvim-dap"),
}

-- Plugin.opts = {}
-- Plugin.config = function(_, opts)
--   -- local dap = require("dap")
--
--   -- dap.adapters.ruby = require("plugins.dap.ruby").config.adapter
--   -- dap.configurations.ruby = require("plugins.dap.ruby").config.configuration
--
--   -- require("dapui").setup({})
--   -- require('dap-ruby').setup({})
--
--   -- vim.keymap.set('n', '<Leader>lp',
--   --   function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
--
--   -- vim.keymap.set({ 'n', 'v' }, '<Leader>dp', require('dap.ui.widgets').preview)
--   -- vim.keymap.set({ 'n', 'v' }, '<Leader>du', require('dapui').toggle)
--
--   -- vim.keymap.set('n', '<Leader>df', function()
--   --   local widgets = require('dap.ui.widgets')
--   --   widgets.centered_float(widgets.frames)
--   -- end)
--
--   -- vim.keymap.set('n', '<Leader>ds', function()
--   --   local widgets = require('dap.ui.widgets')
--   --   widgets.centered_float(widgets.scopes)
--   -- end)
-- end

-- Plugin.keys = function()
--   return {
--     {
--       "<leader>dB",
--       function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
--       desc =
--       "Breakpoint Condition"
--     },
--     { "<leader>dC", require("dap").run_to_cursor,     desc = "Run to Cursor" },
--     { "<leader>dO", require("dap").step_over,         desc = "Step Over" },
--     { "<leader>db", require("dap").toggle_breakpoint, desc = "Toggle Breakpoint" },
--     { "<leader>dc", require("dap").continue,          desc = "Continue" },
--     { "<leader>dg", require("dap").goto_,             desc = "Go to line (no execute)" },
--     { "<leader>di", require("dap").step_into,         desc = "Step Into" },
--     { "<leader>dj", require("dap").down,              desc = "Down" },
--     { "<leader>dk", require("dap").up,                desc = "Up" },
--     { "<leader>dl", require("dap").run_last,          desc = "Run Last" },
--     { "<leader>do", require("dap").step_out,          desc = "Step Out" },
--     { "<leader>dp", require("dap").pause,             desc = "Pause" },
--     { "<leader>dr", require("dap").repl.toggle,       desc = "Toggle REPL" },
--     { "<leader>ds", require("dap").session,           desc = "Session" },
--     { "<leader>dt", require("dap").terminate,         desc = "Terminate" },
--     -- { "<leader>dt", require("dapui").toggle,          desc = "Toggle dapui" },
--     -- {
--     --   "<leader>dw",
--     --   require("dap.ui.widgets").hover,
--     --   { "n", "v" },
--     --   desc = "Widgets"
--     -- },
--     -- {
--     --   "<leader>de",
--     --   require("dap.ui").eval,
--     --   { "n", "v" },
--     --   desc = "Eval",
--     -- },
--   }
-- end

Plugin.init = function()
  vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  -- au FileType dap-repl lua require('dap.ext.autocompl').attach()
  -- vim.cmd [[autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
end

return Plugin
