local wk = require("which-key")

wk.add({
  { "<Esc>",           "<C-\\><C-N>",                                               desc = "Exit terminal",                       mode = "t" },

  {
    "n",
    [[<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>]],
    desc = "Next search match"
  },

  {
    "N",
    [[<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>]],
    desc = "Previous search match"
  },

  { "p",               "p`]",                                                       desc = "Paste, then move to end of text" },
  { "S",               "i<CR><ESC>^mwgk:silent! s/\v +$/<CR>:noh<CR>",              desc = "Split line, remove whitespace" },
  { "y",               "y`]",                                                       desc = "Yank, then move to end of text",      mode = "v" },

  -- ╭─────────────╮
  -- │ Next & Prev │
  -- ╰─────────────╯
  { "]t",              require("todo-comments").jump_next,                          desc = "todo-comment: next" },
  { "[t",              require("todo-comments").jump_prev,                          desc = "todo-comment: previous" },
  { "]n",              require("plugins.neotest").next_failed,                 desc = "Test: next failure" },
  { "[n",              require("plugins.neotest").prev_failed,                 desc = "Test: previous failure" },

  -- ╭──────╮
  -- │ goto │
  -- ╰──────╯
  { "*",               desc = "*<cmd>lua require('hlslens').start()<CR>" },
  { "#",               desc = "#<cmd>lua require('hlslens').start()<CR>" },
  { "gx",              require("open").open_cword,                                  desc = "Open item under cursor" },
  { "g*",              "g*<cmd>lua require('hlslens').start()<CR>" },
  { "g#",              "g#<cmd>lua require('hlslens').start()<CR>" },

  -- ╭──────╮
  -- │ Code │
  -- ╰──────╯
  { "<leader>cb",      require("plugins.comment-box").al_box,                  desc = "Left-aligned box; left-aligned text" },
  { "<leader>cb",      require("plugins.comment-box").al_box,                  desc = "Left-aligned box; left-aligned text", mode = "v" },
  { "<leader>cB",      require("plugins.comment-box").cc_box,                  desc = "Title box" },
  { "<leader>cB",      require("plugins.comment-box").cc_box,                  desc = "Title box",                           mode = "v" },

  { "<leader>cg",      require("neogen").generate,                                  desc = "neogen: Generate annotation" },
  { "<leader>ct",      require("turboladen").strip_tabs,                            desc = "Strip tabs!" },

  -- ╭─────╮
  -- │ DAP │
  -- ╰─────╯
  -- { "<leader>dB",      require('dap').set_breakpoint,                               desc = "DAP: set breakpoint" },
  -- -- { "<F5>",      require('dap').continue,                          desc = "DAP: continue" },
  -- { "<leader>dc",      require('dap').continue,                                     desc = "DAP: continue" },
  -- -- { "<F12>",      require('dap').step_out,                          desc = "DAP: step out" },
  -- { "<leader>dk",      require('dap').step_out,                                     desc = "DAP: step out" },
  -- -- { "<F11>",      require('dap').step_into,                         desc = "DAP: step into" },
  -- { "<leader>dl",      require('dap').step_into,                                    desc = "DAP: step into" },
  -- -- { "<F10>",      require('dap').step_over,                         desc = "DAP: step over" },
  -- { "<leader>dj",      require('dap').step_over,                                    desc = "DAP: step over" },
  -- { "<leader>db",      require('dap').toggle_breakpoint,                            desc = "DAP: toggle breakpoint" },
  -- { "<leader>dr",      require('dap').repl.open,                                    desc = "DAP: open REPL" },
  -- { "<leader>dL",      require('dap').run_last,                                     desc = "DAP: open REPL" },

  -- ╭──────╮
  -- │ Find │
  -- ╰──────╯
  { "<leader><space>", require('telescope.builtin').find_files,                     desc = "tele: find" },
  { "<leader><cr>",    require('telescope.builtin').buffers,                        desc = "tele: buffers" },
  { "<leader>fg",      require('telescope.builtin').git_status,                     desc = "tele: git status" },

  { "<leader>fk",      require('telescope.builtin').grep_string,                    desc = "tele: string grep" },
  { "<leader>fm",      require('telescope.builtin').marks,                          desc = "tele: marks" },
  { "<leader>fo",      require('telescope.builtin').oldfiles,                       desc = "tele: oldfiles" },
  { "<leader>fn",      require('plugins.telescope').nvim_config_files, desc = "tele: ~/.config/nvim/" },
  { "<leader>fy",      require('plugins.telescope').yadm_files,        desc = "tele: YADM files" },
  { "<leader>fa",      "<cmd>Telescope telescope-alternate alternate_file<CR>",     desc = "tele: alternate files" },
  { "<leader>fs",      "<cmd>Telescope aerial<CR>",                                 desc = "tele: aerial symbols" },
  -- t = { "<cmd>lua require('telescope.builtin').grep_string({search = 'TODO'})", "Telescope: TODOs" },
  { "<leader>ft",      "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",            desc = "Todo/Fix/Fixme" },

  -- ╭─────╮
  -- │ Git │
  -- ╰─────╯
  { "<leader>gg",      "<cmd>LazyGit<CR>",                                          desc = "Open lazygit" },

  -- ╭─────╮
  -- │ LSP │
  -- ╰─────╯
  -- See `lua/plugins/nvim-lspconfig.lua`
  { "<leader>ll",      require('lint').try_lint,                                    desc = "Lint" },
  { "<leader>la",      vim.lsp.buf.code_action,                                     desc = "Code action",                         mode = "v" },

  -- ╭──────────╮
  -- │ Packages │
  -- ╰──────────╯
  { "<leader>pu",      "<cmd>Lazy update<CR>",                                      desc = "Lazy: update" },
  { "<leader>pm",      "<cmd>Mason<CR>",                                            desc = "Mason" },

  -- ╭────────╮
  -- │ Search │
  -- ╰────────╯
  { "<leader>/",       require('telescope.builtin').live_grep,                      desc = "tele: live grep" },
  { "<leader>.",       ":Rg2<space>",                                               desc = "rg" },
  { "<leader>sl",      ":noh<CR>",                                                  desc = "Stop highlighting the hlsearch" },

  -- ╭──────╮
  -- │ Test │
  -- ╰──────╯
  { "<leader>tn",      require("plugins.neotest").test_cmds.nearest,           desc = "Test: nearest" },
  { "<leader>tN",      require("plugins.neotest").test_cmds.watch_nearest,     desc = "Test: watch nearest" },

  { "<leader>tf",      require("plugins.neotest").test_cmds.file,              desc = "Test: test this file" },
  { "<leader>tF",      require("plugins.neotest").test_cmds.watch_file,        desc = "Test: watch this file" },

  { "<leader>ta",      require("plugins.neotest").test_cmds.all,               desc = "Test: all tests" },
  { "<leader>tA",      require("plugins.neotest").test_cmds.watch_all,         desc = "Test: watch all tests" },

  -- { "<leader>tl",      require("neotest").run.run_last,                             desc = "Test: Run last test cmd" },

  -- { "<leader>ts",      require("neotest").summary.toggle,                           desc = "Test: toggle summary" },
  -- { "<leader>tC",      require("neotest").summary.clear_marked,                     desc = "Test: summary clear marked" },
  { "<leader>to",      require("plugins.neotest").toggle_output_panel,         desc = "Test: toggle panel" },

  -- { "<leader>tS",      require("neotest").run.stop,                                 desc = "Test: stop!" },

  -- ╭─────────╮
  -- │ Windows │
  -- ╰─────────╯
  { "<C-l>",           "<C-w>l",                                                    desc = "Move to right pane" },
  { "<C-h>",           "<C-w>h",                                                    desc = "Move to left pane" },
  { "<C-j>",           "<C-w>j",                                                    desc = "Move to down pane" },
  { "<C-k>",           "<C-w>k",                                                    desc = "Move to up pane" },

  -- ╭─────────────╮
  -- │ Diagnostics │
  -- ╰─────────────╯
  { "<leader>xx",      "<CMD>Trouble diagnostics toggle<CR>",                       desc = "Diagnostics (Trouble)" },
  { "<leader>xX",      "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",          desc = "Buffer Diagnostics (Trouble)" },
  { "<leader>xs",      "<CMD>Trouble symbols toggle focus=false<CR>",               desc = "Symbols (Trouble)" },
  -- R = { "<cmd>TroubleToggle lsp_references<cr>", "Trouble: LSP references" },
  { "<leader>xl",      "<CMD>Trouble lsp_definitions toggle<CR>",                   desc = "Trouble: LSP Definitions" },
  { "<leader>xL",      "<CMD>Trouble loclist toggle<CR>",                           desc = "Trouble: loclist" },
  { "<leader>xQ",      "<CMD>Trouble quickfix toggle<CR>",                          desc = "Trouble: quickfix" },

  { "<leader>xt",      "<CMD>TodoQuickFix<CR>",                                     desc = "todo-comments: quickfix" },
  { "<leader>xT",      "<CMD>Trouble todo filter = {tag = {TODO,FIX,FIXME}}<CR>",   desc = "todo-comments: via trouble" },
})

local M = {}

--          ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--          ┃                         Aerial                          ┃
--          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
--- Callback function for `aerial.nvim` that sets maps on_attach.
---@param bufnr number The buffer to attach to.
-- M.aerial = function(aerial, bufnr)
--   wk.add({
--     { "<leader>ba", aerial.toggle,   desc = "aerial: Toggle symbols",     buffer = bufnr },
--     { "<leader>bn", "<CMD>AerialNavToggle<CR>", desc = "aerial: Toggle nav symbols", buffer = bufnr },
--
--     -- Jump forwards/backwards with '{' and '}'
--     { "{",          aerial.prev,     desc = "aerial: Previous",           buffer = bufnr },
--     { "}",          aerial.next,     desc = "aerial: Next",               buffer = bufnr },
--
--     -- Jump up the tree with '[[' or ']]'
--     { "[[",         aerial.prev_up,  desc = "aerial: Previous up",        buffer = bufnr },
--     { "]]",         aerial.next_up,  desc = "aerial: Next up",            buffer = bufnr },
--   })
-- end


--          ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--          ┃                    - Crates callback                    ┃
--          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
---@param bufnr number The buffer number.
M.crates = function(bufnr)
  wk.add({
    { "<leader>rt", require("crates").toggle,                             desc = "crates: enable/disable info",       buffer = bufnr },
    { "<leader>rr", require("crates").reload,                             desc = "crates: reload cache",              buffer = bufnr },

    { "<leader>rv", require("crates").show_versions_popup,                desc = "crates: details w/version info",    buffer = bufnr },
    { "<leader>rf", require("crates").show_features_popup,                desc = "crates: details w/feature info",    buffer = bufnr },
    { "<leader>rd", require("crates").show_dependencies_popup,            desc = "crates: details w/dependency info", buffer = bufnr },

    { "<leader>ru", require("crates").update_crate,                       desc = "crates: update selected",           buffer = bufnr },
    { "<leader>rU", require("crates").upgrade_crate,                      desc = "crates: upgrade selected",          buffer = bufnr },
    { "<leader>ra", require("crates").update_all_crates,                  desc = "crates: update all",                buffer = bufnr },
    { "<leader>rA", require("crates").upgrade_all_crates,                 desc = "crates: upgrade all",               buffer = bufnr },

    { "<leader>rx", require("crates").expand_plain_crate_to_inline_table, desc = "crates: Extract to inline-table",   buffer = bufnr },
    { "<leader>rX", require("crates").extract_crate_into_table,           desc = "crates: Extract into table",        buffer = bufnr },

    { "<leader>rH", require("crates").open_homepage,                      desc = "crates: Open home page",            buffer = bufnr },
    { "<leader>rR", require("crates").open_repository,                    desc = "crates: Open repository",           buffer = bufnr },
    { "<leader>rD", require("crates").open_documentation,                 desc = "crates: Open documentation",        buffer = bufnr },
  })
end

--          ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--          ┃                        Gitsigns                         ┃
--          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
--- Maps for `gitsigns.nvim`'s `on_attach`.
---@param bufnr number The buffer number.
M.gitsigns = function(bufnr)
  local gs = require("plugins.gitsigns")

  wk.add({
    { "]c",         gs.get_next_hunk, desc = "gitsigns: Next hunk",        buffer = bufnr },
    { "[c",         gs.get_prev_hunk, desc = "gitsigns: Previous hunk",    buffer = bufnr },
    { "<leader>gb", gs.toggle_blame,  desc = "gitsigns: Toggle git blame", buffer = bufnr },
  })
end

--          ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--          ┃                         treesj                          ┃
--          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
--- Defines keymaps for `treesj`'s autocmd.
---@param langs table
M.treesj = function(langs)
  -- Fallback to splitjoin on unsupported language: https://github.com/Wansmer/treesj/discussions/19
  if langs[vim.bo.filetype] then
    wk.add({
      { "gJ", require("treesj").join,  desc = "treejs: join lines",  buffer = true, noremap = true },
      { "gS", require("treesj").split, desc = "treejs: split lines", buffer = true, noremap = true },
    })
  else
    wk.add({
      { "gJ", "<CMD>SplitjoinJoin<CR>",  desc = "splitjoin: join lines",  buffer = true, noremap = true },
      { "gS", "<CMD>SplitjoinSplit<CR>", desc = "splitjoin: split lines", buffer = true, noremap = true },
    })
  end
end

--          ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--          ┃                        lspconfig                        ┃
--          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
--- Defines keymaps for `lspconfig`'s `on_attach` callback.
---@param bufnr number
M.lspconfig = function(bufnr)
  wk.add({
    -- bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    { "gd",         vim.lsp.buf.definition,                                     desc = "Goto: definition",        buffer = bufnr },

    -- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    { "gD",         vim.lsp.buf.declaration,                                    desc = "Goto: declaration",       buffer = bufnr },

    -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    { "gi",         vim.lsp.buf.implementation,                                 desc = "Goto: implementation",    buffer = bufnr },

    { "gC",         vim.lsp.buf.incoming_calls,                                 desc = "Goto: incoming_calls",    buffer = bufnr },

    -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    { "gR",         "<cmd>Trouble lsp_references toggle focus=false<cr>",       desc = "Trouble: LSP references", buffer = bufnr },

    -- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    -- K = { vim.lsp.buf.signature_help, "Signature help" },
    -- { "gK",         require('turboladen.lsp').hover,                            desc = "Show docs",               buffer = bufnr },
    { "K",          require('turboladen.lsp').hover,                            desc = "Show docs",               buffer = bufnr },

    -- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    { "gy",         vim.lsp.buf.type_definition,                                desc = "Goto: t[y]pe definition", buffer = bufnr },

    -- bufmap({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    { "<leader>=",  vim.lsp.buf.format,                                         desc = "Reformat buffer",         buffer = bufnr },

    { "]g",         vim.diagnostic.goto_next,                                   desc = "next diagnostic",         buffer = bufnr },

    { "[g",         vim.diagnostic.goto_prev,                                   desc = "previous diagnostic",     buffer = bufnr },

    -- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    { "<leader>la", vim.lsp.buf.code_action,                                    desc = "Code action",             buffer = bufnr },

    -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    { "<leader>lr", vim.lsp.buf.rename,                                         desc = "Rename",                  buffer = bufnr },

    -- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    { "<leader>K",  vim.lsp.buf.open_float,                                     desc = "Open float",              buffer = bufnr },

    -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    { "<leader>ls", vim.lsp.buf.signature_help,                                 desc = "Signature help",          buffer = bufnr },
    { "<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, desc = "Show workspace symbols",  buffer = bufnr },
    { "<leader>lW", require("telescope.builtin").lsp_document_symbols,          desc = "Show doc symbols",        buffer = bufnr },
    {
      "<leader>lf",
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = "List workspace folders",
      buffer = bufnr
    },

    -- Diagnostics
    {
      "<leader>lx",
      function() require("telescope.builtin").diagnostics({ bufnr = 0, severity = "Error" }) end,
      desc = "LSP: Buffer errors",
      buffer = bufnr
    },
    {
      "<leader>lX",
      function() require("telescope.builtin").diagnostics({ severity = "Error" }) end,
      desc = "LSP: All errors",
      buffer = bufnr
    },
    {
      "<leader>ld",
      function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
      desc = "LSP: Buffer diagnostics",
      buffer = bufnr
    },
    {
      "<leader>lD",
      require("telescope.builtin").diagnostics,
      desc = "LSP: All Diagnostics",
      buffer = bufnr
    },
  })
end

return M
