local wk = require("which-key")

wk.register({
  g = {
    ["*"] = { "g*<cmd>lua require('hlslens').start()<CR>" },
    ["#"] = { "g#<cmd>lua require('hlslens').start()<CR>" },
  },

  n = { [[<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>]], "Next search match" },
  N = {
    [[<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>]], "Previous search match"
  },

  p = { "p`]", "Paste, then move to end of text" },
  S = { "i<CR><ESC>^mwgk:silent! s/\v +$/<CR>:noh<CR>", "Split line, remove whitespace" },
  y = { "y`]", "Yank, then move to end of text", mode = "v" },
  -- ["<ESC>"] = { "<C-\\><C-N>", "Terminal: exit", mode = "t" },

  ["]"] = {
    name = "+next",
    g = { vim.diagnostic.goto_next, "diagnostic" },
    t = { require("todo-comments").jump_next, "todo-comment" }, -- folke/todo-comments
  },

  ["["] = {
    name = "+prev",
    g = { vim.diagnostic.goto_prev, "diagnostic" },
    t = { require("todo-comments").jump_prev, "todo-comment" }, -- folke/todo-comments
  },

  --  ╭─────────╮
  --  │ hlslens │
  --  ╰─────────╯
  ["*"] = { "*<cmd>lua require('hlslens').start()<CR>" },
  ["#"] = { "#<cmd>lua require('hlslens').start()<CR>" },
  ["<C-l>"] = { "<C-w>l", "Move to right pane" },
  ["<C-h>"] = { "<C-w>h", "Move to left pane" },
  ["<C-j>"] = { "<C-w>j", "Move to down pane" },
  ["<C-k>"] = { "<C-w>k", "Move to up pane" },

  ["<leader>"] = {
    ["<space>"] = { require('telescope.builtin').find_files, "tele: find" },
    ["<cr>"] = { require('telescope.builtin').buffers, "tele: buffers" },
    ["/"] = { require('telescope.builtin').live_grep, "tele: live grep" },
    ["."] = { ":Rg<space>", "rg" },
    l = { ":noh<CR>", "Stop highlighting the hlsearch" },
  },

  ["<leader>a"] = {
    g = { require("neogen").generate, "neogen: Generate annotation" },
  },

  ["<leader>b"] = {
    name = "+boxes",
    b = { require("turboladen").al_box, "Left-aligned box; left-aligned text" },
    t = { require("turboladen").cc_box, "Title box" }
  },

  -- ["<leader>d"] = {
  --   name = "+dap",
  --   c = { require('dap').continue, "DAP: continue" },
  --   k = { require('dap').step_out, "DAP: step out" },
  --   l = { require('dap').step_into, "DAP: step into" },
  --   j = { require('dap').step_over, "DAP: step over" },
  --   b = { require('dap').toggle_breakpoint, "DAP: toggle breakpoint" },
  --   r = { require('dap').repl.open, "DAP: open REPL" },
  --   L = { require('dap').run_last, "DAP: open REPL" },
  --   e = { "lua require('dap').set_exception_breakpoints({'all'})", "DAP: set breakpoints on all exceptions" },
  --   t = { require('dap.ui').toggle, "DAP UI: toggle" },
  --   -- i = { require('dap.ui.variables').visual_hover },
  --   -- ["?"] = { require('dap.ui.variables').scopes },
  -- },

  ["<leader>f"] = {
    name = "+find",
    k = { require('telescope.builtin').grep_string, "tele: string grep" },
    m = { require('telescope.builtin').marks, "tele: marks" },
    o = { require('telescope.builtin').oldfiles, "tele: oldfiles" },
    n = { require('plugins.editor.telescope_utils').nvim_config_files, "tele: ~/.config/nvim/" },
    y = { require('plugins.editor.telescope_utils').yadm_files, "tele: YADM files" },
    a = { "<cmd>Telescope telescope-alternate alternate_file<CR>", "tele: alternate files" },
    s = { "<cmd>Telescope aerial<CR>", "tele: aerial symbols" },
    -- t = { "<cmd>lua require('telescope.builtin').grep_string({search = 'TODO'})", "Telescope: TODOs" },
    t = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme" },
  },

  ["<leader>g"] = {
    name = "+git",
    s = { "<cmd>lua require('neogit').open({kind = 'split'})<CR>", "Open neogit" },
    g = { "<cmd>LazyGit<CR>", "Open lazygit" }
  },

  -- See `lua/plugins/nvim-lspconfig.lua`
  ["<leader>l"] = {
    name = "+lsp",
    l = { require('lint').try_lint, "Lint" },
  },

  ["<leader>p"] = {
    name = "+packages",
    u = { "<cmd>Lazy update<CR>", "Lazy: update" },
    m = { "<cmd>Mason<CR>", "Mason" },
  },

  ["<leader>st"] = { require("turboladen").strip_tabs, "Strip tabs!" },

  ["<leader>t"] = {
    name = "+test",
    n = { "<cmd>TestNearest<cr>", "Test: nearest" },
    f = { "<cmd>TestFile<cr>", "Test: file" },
    a = { "<cmd>TestSuite<cr>", "Test: all" },
    l = { "<cmd>TestLast<cr>", "Test: last" },
    v = { "<cmd>TestVisit<cr>", "Test: visit" },
  },

  ["<leader>x"] = {
    name = "+diagnostics",
    x = { require('trouble').toggle, "Trouble" },
    r = { require('trouble').refresh, "Trouble: refresh" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble: workspace diags" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble: doc diags" },
    -- R = { "<cmd>TroubleToggle lsp_references<cr>", "Trouble: LSP references" },
    D = { "<cmd>TroubleToggle lsp_definitions<cr>", "Trouble: LSP [D]efinitions" },
    y = { "<cmd>TroubleToggle lsp_type_definitions<cr>", "Trouble: LSP t[y]pedefs" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Trouble: loclist" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble: quickfix" },
    -- q = { vim.diagnostic.setloclist, "Add buffer diagnostics to loclist" },
    t = { "<cmd>TodoTrouble keywords=TODO,FIXME<CR>", "Trouble: TODO/FIXME" }, -- folke/todo-comments.nvim

    ["["] = {
      "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>",
      "Trouble: next item"
    },

    ["]"] = {
      "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>",
      "Trouble: previous item"
    },
  },
})

-- Visual mode mappings
wk.register({
  p = { "\"_dP", "Paste, then move to end of text" },

  ["<leader>b"] = {
    b = { require("turboladen").al_box, "Left-aligned box; left-aligned text" },
    t = { require("turboladen").cc_box, "Title box" }
  },

  ["<leader>l"] = {
    a = { vim.lsp.buf.code_action, "Code action" },
  },
}, {
  mode = "v"
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Exit terminal" })
