-- General options and settings
local opt = vim.opt

-- Basic editor settings
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.signcolumn = "yes" -- Always show sign column
opt.wrap = false -- Don't wrap lines
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Indentation
opt.tabstop = 2 -- Number of spaces a tab counts for
opt.shiftwidth = 2 -- Number of spaces to use for autoindent
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true

-- Search
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Override ignorecase if search contains uppercase
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Show search matches as you type

-- UI
opt.termguicolors = true -- Enable 24-bit color
opt.cursorline = true -- Highlight current line
opt.splitbelow = true -- Open horizontal splits below
opt.splitright = true -- Open vertical splits to the right

-- Performance
opt.updatetime = 250 -- Faster completion
opt.timeoutlen = 300 -- Faster key sequence completion

-- Backup and undo
opt.backup = false
opt.writebackup = false
opt.undofile = true -- Enable persistent undo
opt.swapfile = false

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Mouse
opt.mouse = "a" -- Enable mouse support
