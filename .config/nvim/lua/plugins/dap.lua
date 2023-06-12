-- ╭─────────────────────────────────────────────────────────╮
-- │ Debug Adapter Protocol client implementation for Neovim │
-- ╰─────────────────────────────────────────────────────────╯
-- NOTES!
-- 1. To debug rust stuff, I'm using rust-tools setup... which means, I need to run :RustDebuggables
--    instead of pressing F5.
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    -- ╭───────────────────╮
    -- │ A UI for nvim-dap │
    -- ╰───────────────────╯
    { "rcarriga/nvim-dap-ui", opts = {} },
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
    { "suketa/nvim-dap-ruby" }
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

    vim.keymap.set('n', '<F5>', require('dap').continue)
    vim.keymap.set('n', '<F10>', require('dap').step_over)
    vim.keymap.set('n', '<F11>', require('dap').step_into)
    vim.keymap.set('n', '<F12>', require('dap').step_out)
    vim.keymap.set('n', '<Leader>b', require('dap').toggle_breakpoint)
    vim.keymap.set('n', '<Leader>B', require('dap').set_breakpoint)
    vim.keymap.set('n', '<Leader>lp',
      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', require('dap').repl.open)
    vim.keymap.set('n', '<Leader>dl', require('dap').run_last)

    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', require('dap.ui.widgets').hover)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', require('dap.ui.widgets').preview)
    vim.keymap.set({ 'n', 'v' }, '<Leader>du', require('dapui').toggle)

    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)

    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)
  end,
  init = function()
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

    -- au FileType dap-repl lua require('dap.ext.autocompl').attach()
    vim.cmd [[autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
  end
}
