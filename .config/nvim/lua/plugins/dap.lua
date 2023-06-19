-- ╭─────────────────────────────────────────────────────────╮
-- │ Debug Adapter Protocol client implementation for Neovim │
-- ╰─────────────────────────────────────────────────────────╯
-- NOTES!
-- 1. To debug rust stuff, I'm using rust-tools setup... which means, I need to run :RustDebuggables
--    instead of pressing F5.
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- ╭───────────────────╮
    -- │ A UI for nvim-dap │
    -- ╰───────────────────╯
    {
      "rcarriga/nvim-dap-ui",
      opts = {},
      config = function(_, opts)
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
      end,
    },
    {
      -- ╭────────────────────────────────────────────────────╮
      -- │ This plugin adds virtual text support to nvim-dap. │
      -- ╰────────────────────────────────────────────────────╯
      "theHamsta/nvim-dap-virtual-text",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "mfussenegger/nvim-dap",
      },
      opts = { commented = true },
    },
    { "suketa/nvim-dap-ruby" },
    -- which key integration
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
          ["<leader>da"] = { name = "+adapters" },
        },
      },
    },
    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },
  opts = {},
  config = function(_, opts)
    local dap = require("dap")

    -- dap.adapters.ruby = function(callback, config)
    --   callback {
    --     type = "server",
    --     host = "127.0.0.1",
    --     port = "${port}",
    --     executable = {
    --       command = "bundle",
    --       args = { "exec", "rdbg", "-n", "--open", "--host", "${host}", "--port", "${port}",
    --         "-c", "--", "bundle", "exec", config.command, config.script,
    --       },
    --     },
    --   }
    -- end

    -- dap.adapters.ruby = {
    --   type = "executable",
    --   command = "readapt",
    --   args = { "stdio" }
    -- }

    -- dap.configurations.ruby = {
    --   {
    --     type = "ruby",
    --     request = "launch",
    --     name = "Ruby",
    --     program = "bundle",
    --     programArgs = { "exec", "rspec" },
    --     useBundler = false
    --   }
    -- }

    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    -- dap.configurations.ruby = {
    --   {
    --     type = "ruby",
    --     name = "debug current file",
    --     request = "attach",
    --     localfs = true,
    --     command = "ruby",
    --     script = "${file}",
    --   },
    --   {
    --     type = "ruby",
    --     name = "run current spec file",
    --     request = "attach",
    --     localfs = true,
    --     command = "rspec",
    --     script = "${file}",
    --   },
    -- }

    require("dapui").setup({})
    require('dap-ruby').setup({})
    -- dap.adapters.ruby = opts.adapters.ruby
    -- dap.configurations.ruby = opts.configurations.ruby

    -- vim.keymap.set('n', '<F5>', require('dap').continue)
    -- vim.keymap.set('n', '<F10>', require('dap').step_over)
    -- vim.keymap.set('n', '<F11>', require('dap').step_into)
    -- vim.keymap.set('n', '<F12>', require('dap').step_out)
    -- vim.keymap.set('n', '<Leader>db', require('dap').toggle_breakpoint)
    -- vim.keymap.set('n', '<Leader>dB', require('dap').set_breakpoint)
    -- vim.keymap.set('n', '<Leader>lp',
    --   function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    -- vim.keymap.set('n', '<Leader>dr', require('dap').repl.open)
    -- vim.keymap.set('n', '<Leader>dl', require('dap').run_last)

    -- vim.keymap.set({ 'n', 'v' }, '<Leader>dp', require('dap.ui.widgets').preview)
    -- vim.keymap.set({ 'n', 'v' }, '<Leader>du', require('dapui').toggle)

    -- vim.keymap.set('n', '<Leader>df', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.frames)
    -- end)

    -- vim.keymap.set('n', '<Leader>ds', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.scopes)
    -- end)
  end,
  keys = function()
    -- local dapui = require("dapui")

    -- return {
    --   { "<leader>du", function() dapui.toggle({}) end,  desc = "Dap UI" },
    -- }
    return {
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc =
        "Breakpoint Condition"
      },
      { "<leader>dC", require("dap").run_to_cursor,     desc = "Run to Cursor" },
      { "<leader>dO", require("dap").step_over,         desc = "Step Over" },
      { "<leader>db", require("dap").toggle_breakpoint, desc = "Toggle Breakpoint" },
      { "<leader>dc", require("dap").continue,          desc = "Continue" },
      { "<leader>dg", require("dap").goto_,             desc = "Go to line (no execute)" },
      { "<leader>di", require("dap").step_into,         desc = "Step Into" },
      { "<leader>dj", require("dap").down,              desc = "Down" },
      { "<leader>dk", require("dap").up,                desc = "Up" },
      { "<leader>dl", require("dap").run_last,          desc = "Run Last" },
      { "<leader>do", require("dap").step_out,          desc = "Step Out" },
      { "<leader>dp", require("dap").pause,             desc = "Pause" },
      { "<leader>dr", require("dap").repl.toggle,       desc = "Toggle REPL" },
      { "<leader>ds", require("dap").session,           desc = "Session" },
      { "<leader>dt", require("dap").terminate,         desc = "Terminate" },
      { "<leader>d?", require("dap.ui.widgets").scopes, desc = "dap: show scopes" },
      {
        "<leader>dw",
        require("dap.ui.widgets").hover,
        { "n", "v" },
        desc = "Widgets"
      },
      {
        "<leader>de",
        require("dap.ui").eval,
        { "n", "v" },
        desc = "Eval",
      },
    }
  end,
  init = function()
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- au FileType dap-repl lua require('dap.ext.autocompl').attach()
    vim.cmd [[autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
  end,
}
