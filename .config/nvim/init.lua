-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                                                              │
-- │                                   init.lua                                   │
-- │                                                                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.options')
load('user.commands')
-- load('user.keymaps')
-- require('user.plugins')

-- pcall(vim.cmd.colorscheme, 'tokyonight')

-- ╭────────────────────────────────╮
-- │ 0.1. Define functions for init │
-- ╰────────────────────────────────╯
local function set_host_progs()
  -- let node_host_path = '/Users/steve.loveless/.nvm/versions/node/v16.16.0/bin'
  -- let $PATH = node_host_path . ':' . $PATH
  -- let g:node_host_prog = node_host_path . '/node'
  vim.g.node_host_prog = 'Users/steve.loveless/.nvm/versions/node/v16.16.0/lib/node_modules'
  -- vim.g.python_host_prog = vim.g.turboladen_homebrew_prefix .. '/bin/python2'
  -- vim.g.python3_host_prog = vim.g.turboladen_homebrew_prefix .. '/bin/python3'
end

-- ╭───────────────────────────────────────────────────╮
-- │ 0. Load special things before plugins stuff first │
-- ╰───────────────────────────────────────────────────╯
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_perl_provider = 0

--  ╭──────────────────╮
--  │ lazy.nvim things │
--  ╰──────────────────╯
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  dev = {
    path = "~/Development/projects/",
  },
  install = {
    colorscheme = { "nightfox" }
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "tarPlugin",
        "tutor",
        "zipPlugin"
      }
    }
  }
})


-- Set the global var for the homebrew prefix.
-- require('turboladen/homebrew').prefix()

set_host_progs()

vim.cmd.colorscheme("nightfox")
-- vim.cmd.colorscheme("kanagawa")
-- vim.cmd.colorscheme("everforest")
-- vim.cmd.colorscheme("material")
-- vim.cmd.colorscheme("falcon")
-- vim.cmd.colorscheme("github_dark_default")
-- vim.cmd.colorscheme("kosmikoa")
-- vim.cmd.colorscheme("kuroi")
-- vim.cmd.colorscheme("nordbuddy")
-- vim.cmd.colorscheme("uwu")

-- For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
-- vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = true


--  ╭───────────────╮
--  │ 15. diff mode │
--  ╰───────────────╯
--  ╭────────────────────────────────────────────────────────────────────────╮
--  │ 16. mapping                                                            │
--  │ Trying out these options before deciding to keep them around (and move │
--  │ to their proper spot).                                                 │
--  ╰────────────────────────────────────────────────────────────────────────╯
local wk = require("which-key")

wk.register({
  g = {
    ["*"] = { "g*<cmd>lua require('hlslens').start()<CR>" },
    ["#"] = { "g#<cmd>lua require('hlslens').start()<CR>" },
    K = { vim.lsp.buf.signature_help, "Signature help" },
    y = { vim.lsp.buf.type_definition, "Goto: t[y]pe definition" }
  },

  -- K = { vim.lsp.buf.hover, "Show docs" },
  K = { require('turboladen.lsp').hover, "Show docs" },
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
  ["<C->"] = {
    ["j"] = { "<C-w>j", "Move to down pane" },
  },

  ["<leader>"] = {
    ["<space>"] = { require('telescope.builtin').find_files, "tele: find" },
    ["<cr>"] = { require('telescope.builtin').buffers, "tele: buffers" },
    -- for some reason, I can't just call the lua function directly here
    ["="] = { ":lua vim.lsp.buf.format({ async = false })<cr>", "Reformat buffer" },
    ["/"] = { require('telescope.builtin').live_grep, "tele: live grep" },
    ["."] = { ":Rg<space>", "rg" },
    l = { ":noh<CR>", "Stop highlighting the hlsearch" },
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

  ["<leader>e"] = {
    name = "+edit",
    v = { "vsplit $MYVIMRC", "Edit init.lua" },
    p = { "vsplit $HOME/.config/nvim/lua/plugins", "Edit plugins/" },
    l = { "vsplit $HOME/.config/nvim/lua/plugins/lsp.lua", "Edit lsp.lua" },
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
    s = { "<cmd>lua require('neogit').open({kind = 'split'})<CR>", "Open neogit" },
    g = { "<cmd>LazyGit<CR>", "Open lazygit" }
  },

  ["<leader>l"] = {
    name = "+lsp",
    a = { vim.lsp.buf.code_action, "Code action" },
    r = { vim.lsp.buf.rename, "Rename" },
    o = { require("telescope.builtin").lsp_document_symbols, "Show doc symbols" },
    w = { require("telescope.builtin").lsp_dynamic_workspace_symbols, "Show workspace symbols" },
    l = { require('lint').try_lint, "Lint" },
    f = { function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders" },
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
    R = { "<cmd>TroubleToggle lsp_references<cr>", "Trouble: LSP references" },
    D = { "<cmd>TroubleToggle lsp_definitions<cr>", "Trouble: LSP [D]efinitions" },
    y = { "<cmd>TroubleToggle lsp_type_definitions<cr>", "Trouble: LSP t[y]pedefs" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Trouble: loclist" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble: quickfix" },
    -- q = { vim.diagnostic.setloclist, "Add buffer diagnostics to loclist" },
    t = { "<cmd>TodoTrouble keywords=TODO,FIXME<CR>", "Trouble: TODO/FIXME" }, -- folke/todo-comments.nvim

    ["["] = {
      "lua require('trouble').next({skip_groups = true, jump = true})",
      "Trouble: next item"
    },

    ["]"] = {
      "lua require('trouble').previous({skip_groups = true, jump = true})",
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

vim.cmd([[setglobal expandtab]])

vim.keymap.set("n", "<leader>st", require("turboladen").strip_tabs, { desc = "Strip tabs!" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Exit terminal" })

vim.keymap.set("n", "<C-j>", "<C-w>j")
