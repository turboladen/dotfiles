local wk = require("which-key")

wk.register({
  g = {
    x = { require("open").open_cword, "Open item under cursor" },
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
    t = { require("todo-comments").jump_next, "todo-comment" }, -- folke/todo-comments
    n = { require("plugins.nvim_neotest").next_failed, "Test: next failure" }
  },

  ["["] = {
    name = "+prev",
    t = { require("todo-comments").jump_prev, "todo-comment" }, -- folke/todo-comments
    n = { require("plugins.nvim_neotest").prev_failed, "Test: previous failure" }
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
    -- a = { "<cmd>SymbolsOutline<cr>", "Toggle symbols" },
    g = { require("neogen").generate, "neogen: Generate annotation" },
  },

  ["<leader>b"] = {
    name = "+boxes",
    b = { require("turboladen").al_box, "Left-aligned box; left-aligned text" },
    t = { require("turboladen").cc_box, "Title box" }
  },

  ["<leader>d"] = {
    name = "+dap",
    -- vim.keymap.set('n', '<Leader>dB', require('dap').set_breakpoint)
    B = { require('dap').set_breakpoint, "DAP: set breakpoint" },
    -- vim.keymap.set('n', '<F5>', require('dap').continue)
    c = { require('dap').continue, "DAP: continue" },
    -- vim.keymap.set('n', '<F12>', require('dap').step_out)
    k = { require('dap').step_out, "DAP: step out" },
    -- vim.keymap.set('n', '<F11>', require('dap').step_into)
    l = { require('dap').step_into, "DAP: step into" },
    -- vim.keymap.set('n', '<F10>', require('dap').step_over)
    j = { require('dap').step_over, "DAP: step over" },
    -- vim.keymap.set('n', '<Leader>db', require('dap').toggle_breakpoint)
    b = { require('dap').toggle_breakpoint, "DAP: toggle breakpoint" },
    -- vim.keymap.set('n', '<Leader>dr', require('dap').repl.open)
    r = { require('dap').repl.open, "DAP: open REPL" },
    -- vim.keymap.set('n', '<Leader>dl', require('dap').run_last)
    L = { require('dap').run_last, "DAP: open REPL" },
    --   e = { "lua require('dap').set_exception_breakpoints({'all'})", "DAP: set breakpoints on all exceptions" },
    --   t = { require('dap.ui').toggle, "DAP UI: toggle" },
    --   -- i = { require('dap.ui.variables').visual_hover },
    --   -- ["?"] = { require('dap.ui.variables').scopes },
  },

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
    n = { require("plugins.nvim_neotest").test_cmds.nearest, "Test: nearest" },
    N = { require("plugins.nvim_neotest").test_cmds.watch_nearest, "Test: watch nearest" },

    f = { require("plugins.nvim_neotest").test_cmds.file, "Test: test this file" },
    F = { require("plugins.nvim_neotest").test_cmds.watch_file, "Test: watch this file" },

    a = { require("plugins.nvim_neotest").test_cmds.all, "Test: all tests" },
    A = { require("plugins.nvim_neotest").test_cmds.watch_all, "Test: watch all tests" },

    l = { require("neotest").run.run_last, "Test: Run last test cmd" },

    s = { require("neotest").summary.toggle, "Test: toggle summary" },
    o = { require("plugins.nvim_neotest").toggle_output, "Test: show output" },
    O = { require("neotest").output_panel.toggle, "Test: toggle panel" },

    S = { require("neotest").run.stop, "Test: stop!" },
  },

  -- ["<leader>x"] = {
  --   name = "+diagnostics",
  --   x = { require('trouble').toggle, "Trouble" },
  --   r = { require('trouble').refresh, "Trouble: refresh" },
  --   w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble: workspace diags" },
  --   d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble: doc diags" },
  --   -- R = { "<cmd>TroubleToggle lsp_references<cr>", "Trouble: LSP references" },
  --   D = { "<cmd>TroubleToggle lsp_definitions<cr>", "Trouble: LSP [D]efinitions" },
  --   y = { "<cmd>TroubleToggle lsp_type_definitions<cr>", "Trouble: LSP t[y]pedefs" },
  --   l = { "<cmd>TroubleToggle loclist<cr>", "Trouble: loclist" },
  --   q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble: quickfix" },
  --   -- q = { vim.diagnostic.setloclist, "Add buffer diagnostics to loclist" },
  --   t = { "<cmd>TodoTrouble keywords=TODO,FIXME<CR>", "Trouble: TODO/FIXME" }, -- folke/todo-comments.nvim
  --
  --   ["["] = {
  --     "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>",
  --     "Trouble: next item"
  --   },
  --
  --   ["]"] = {
  --     "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>",
  --     "Trouble: previous item"
  --   },
  -- },
})

-- Visual mode mappings
wk.register({
  p = { "\"_dP", "Paste, then move to end of text" },

  ["<leader>b"] = {
    b = { require("turboladen").al_box, "Left-aligned box; left-aligned text" },
    t = { require("turboladen").cc_box, "Title box" }
  },
}, {
  mode = "v"
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Exit terminal" })

local M = {}

M.aerial = function(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Aerial does not set any mappings by default, so you'll want to set some up
  -- Toggle the aerial window with <leader>a
  vim.keymap.set("n", "<leader>aa", require("aerial").toggle, opts)

  -- Jump forwards/backwards with '{' and '}'
  vim.keymap.set("n", "{", require("aerial").prev, opts)
  vim.keymap.set("n", "}", require("aerial").next, opts)

  -- Jump up the tree with '[[' or ']]'
  vim.keymap.set("n", "[[", require('aerial').prev_up, opts)
  vim.keymap.set("n", "]]", require('aerial').next_up, opts)
end

M.crates = function(ev)
  local function opts(desc)
    return {
      buffer = ev.buf,
      desc = desc
    }
  end
  local crates = require("crates")

  -- vim.keymap.set('n', '<leader>ct', "<cmd>lua require('crates').toggle<cr>", opts("crates: enable/disable info"))
  vim.keymap.set('n', '<leader>ct', crates.toggle, opts("crates: enable/disable info"))
  vim.keymap.set('n', '<leader>cu', crates.upgrade_crate, opts("crates: update current"))
  vim.keymap.set('n', '<leader>cl', crates.upgrade_all_crates, opts("crates: update all"))
  vim.keymap.set("n", "<leader>cr", crates.reload, opts("crates: reload cache"))
  vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts("crates: details w/version info"))
  vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts("crates: details w/feature info"))
end

M.gitsigns = function(bufnr)
  local gs = package.loaded.gitsigns

  local function get_next_hunk()
    if vim.wo.diff then return ']c' end
    -- vim.schedule(function() require("gitsigns").next_hunk() end)
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end

  local function get_prev_hunk()
    if vim.wo.diff then return '[c' end
    -- vim.schedule(function() require("gitsigns").prev_hunk() end)
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end

  local function toggle_blame()
    -- require("gitsigns").toggle_current_line_blame()
    gs.toggle_current_line_blame({ full = true })
  end

  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
  end

  -- Actions
  map("n", "]c", get_next_hunk, "Next hunk")
  map("n", "[c", get_prev_hunk, "Previous hunk")
  map("n", "<leader>ghb", toggle_blame, "Toggle git blame line")
end

--- Defines keymaps for `treesj`'s autocmd.
---@param langs table
M.treesj = function(langs)
  local map_opts = { buffer = true, noremap = true }

  -- Fallback to splitjoin on unsupported language: https://github.com/Wansmer/treesj/discussions/19
  if langs[vim.bo.filetype] then
    if vim.bo.filetype == "rust" then
      vim.keymap.set('n', 'gJ', "<cmd>RustLsp joinLines<cr>", map_opts)
    else
      vim.keymap.set('n', 'gJ', require("treesj").join, map_opts)
    end
    vim.keymap.set('n', 'gS', require("treesj").split, map_opts)
  else
    vim.keymap.set('n', 'gS', '<Cmd>SplitjoinSplit<CR>', map_opts)
    vim.keymap.set('n', 'gJ', '<Cmd>SplitjoinJoin<CR>', map_opts)
  end
end

--- Defines keymaps for `lspconfig`'s `on_attach` callback.
---@param bufnr number
M.lspconfig = function(bufnr)
  local wk = require("which-key")

  wk.register({
    g = {
      -- bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
      d = { vim.lsp.buf.definition, "Goto: definition", buffer = bufnr },

      -- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
      D = { vim.lsp.buf.declaration, "Goto: declaration", buffer = bufnr },

      -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
      i = { vim.lsp.buf.implementation, "Goto: implementation", buffer = bufnr },

      c = { vim.lsp.buf.incoming_calls, "Goto: incoming_calls", buffer = bufnr },

      -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
      R = { "<cmd>TroubleToggle lsp_references<cr>", "Trouble: LSP references", buffer = bufnr },

      -- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
      -- K = { vim.lsp.buf.signature_help, "Signature help" },
      K = { require('turboladen.lsp').hover, "Show docs", buffer = bufnr },

      -- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
      y = { vim.lsp.buf.type_definition, "Goto: t[y]pe definition", buffer = bufnr }
    },

    -- bufmap({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    ["<leader>="] = { vim.lsp.buf.format, "Reformat buffer", buffer = bufnr },

    ["]"] = {
      -- bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
      g = { vim.diagnostic.goto_next, "diagnostic", buffer = bufnr },
    },

    ["["] = {
      -- bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
      g = { vim.diagnostic.goto_prev, "diagnostic", buffer = bufnr },
    },

    ["<leader>l"] = {
      -- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
      a = {
        vim.lsp.buf.code_action,
        "Code action",
        buffer = bufnr
      },

      -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
      r = { vim.lsp.buf.rename, "Rename", buffer = bufnr },

      -- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
      l = { vim.lsp.buf.open_float, "Open float", buffer = bufnr },

      -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
      s = { vim.lsp.buf.signature_help, "Signature help", buffer = bufnr },
      w = { require("telescope.builtin").lsp_dynamic_workspace_symbols, "Show workspace symbols", buffer = bufnr },
      W = { require("telescope.builtin").lsp_document_symbols, "Show doc symbols", buffer = bufnr },
      f = {
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        "List workspace folders",
        buffer = bufnr
      },

      -- Diagnostics
      x = { function() require("telescope.builtin").diagnostics({ bufnr = 0, severity = "Error" }) end, "LSP: Buffer errors" },
      X = { function() require("telescope.builtin").diagnostics({ severity = "Error" }) end, "LSP: All errors" },
      d = { function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, "LSP: Buffer diagnostics" },
      D = { require("telescope.builtin").diagnostics, "LSP: All Diagnostics" },
    },
  })

  -- ╭──────────────────────╮
  -- │ Visual mode mappings │
  -- ╰──────────────────────╯
  wk.register({
    ["<leader>l"] = {
      a = { vim.lsp.buf.code_action, "Code action" },
    },
  }, {
    mode = "v"
  })
end

return M
