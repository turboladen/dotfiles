-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                                                              │
-- │                                   init.vim                                   │
-- │                                                                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- ╭────────────────────────────────╮
-- │ 0.1. Define functions for init │
-- ╰────────────────────────────────╯
local function set_host_progs()
  -- let node_host_path = '/Users/steve.loveless/.nvm/versions/node/v16.16.0/bin'
  -- let $PATH = node_host_path . ':' . $PATH
  -- let g:node_host_prog = node_host_path . '/node'
  vim.g.node_host_prog = 'Users/steve.loveless/.nvm/versions/node/v16.16.0/lib/node_modules'
  vim.g.python_host_prog = vim.g.turboladen_homebrew_prefix .. '/bin/python2'
  vim.g.python3_host_prog = vim.g.turboladen_homebrew_prefix .. '/bin/python3'
end

-- ╭───────────────────────────────────────────────────────────────────────────────╮
-- │ Note to self: When I switched to nvim-oxi, I switched to follow its convention│
-- │ for loading the .so: put it in a dir that's in rtp, letting us load that by   │
-- │ simply doing:                                                                 │
-- │ lua require('init_rs')                                                        │
-- ╰───────────────────────────────────────────────────────────────────────────────╯
local function load_init_rs()
  local ffi = require("ffi")

  ffi.cdef [[
void init_mappings(void);
void init_options(void);
]]

  local project_path = vim.env.HOME .. "/Development/projects/init.rs"
  local suffix = ffi.os == "OSX" and ".dylib" or ".so"

  local lib = ffi.load(project_path .. "/target/release/libinit_rs" .. suffix)
  -- local lib = ffi.load(project_path .. "/target/debug/libnvim_rust_init" .. suffix)
  lib.init_mappings()
  lib.init_options()
end

local function define_wasm_autocmds()
  -- vim -b : edit binary using xxd-format!
  local wasm_group = vim.api.nvim_create_augroup("WasmGroup", {})

  vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "let &bin=1"
  })

  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "if &bin | %!xxd"
  })
  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "set ft=xxd | endif"
  })

  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "if &bin | %!xxd -r"
  })
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "endif"
  })

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "if &bin | %!xxd"
  })
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = "*.wasm",
    group = wasm_group,
    command = "set nomod | endif"
  })
end

local function set_wild_opts()
  vim.opt.wildmode = { 'longest', 'full' }
  vim.opt.wildmenu = true

  vim.opt.wildignore = {
    -- Disable output and VCS files
    '*.o', '*.out', '*.obj', '*.rbc', '*.rbo',

    -- Disable archive files
    '*.zip', '*.tar.gz', '*.tar.bz2', '*.rar', '*.tar.xz',

    -- Ignore rails temporary asset caches
    '*/tmp/cache/assets/*/sprockets/*', '*/tmp/cache/assets/*/sass/*',

    -- Disable temp and backup files
    '*.swp', '*~', '._*',

    -- Ignore simplecov generated coverage docs
    'coverage/*',
  }
end

-- ╭────────────────────────────╮
-- │ 0. Load packer stuff first │
-- ╰────────────────────────────╯
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_perl_provider = 0
vim.opt.termguicolors = true

-- lazy.nvim things
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
    patterns = { "turboladen" },
  },
  install = {
    colorscheme = { "nightfox" }
  },
  checker = {
    enabled = true
  }
})

-- Set the global var for the homebrew prefix.
require('turboladen/homebrew').prefix()

set_host_progs()
load_init_rs()

-- ╭────────────────────╮
-- │ 4. displaying text │
-- ╰────────────────────╯
-- set guifont=MonoLisaCustom\ Nerd\ Font:h13:i
vim.opt.guifont = 'MonoLisaCustom Nerd Font:h13:i'

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
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = true

-- ╭──────────────────────────────────────╮
-- │ 5. syntax, highlighting and spelling │
-- ╰──────────────────────────────────────╯
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

define_wasm_autocmds()

-- ╭────────────────────────────────────────────────────────────────────────╮
-- │ 17. mappings                                                           │
-- │ Trying out these options before deciding to keep them around (and move │
-- │ to their proper spot).                                                 │
-- ╰────────────────────────────────────────────────────────────────────────╯

vim.cmd([[setglobal expandtab]])

-- ╭──────────────────────────╮
-- │ 20. command line editing │
-- ╰──────────────────────────╯
set_wild_opts()

vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('meowersdfsd', {}),
  pattern = "lua",
  callback = function(ev)
    vim.opt_local.expandtab = true
  end,
})

vim.keymap.set("n", "<leader>st", require("turboladen").strip_tabs, { desc = "Strip tabs!" })

vim.api.nvim_create_autocmd({ "BufNewFile", 'BufRead' }, {
  group = vim.api.nvim_create_augroup('justfile_detect', {}),
  pattern = "justfile",
  callback = function()
    vim.opt_local.filetype = "just"
  end,
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Exit terminal" })
