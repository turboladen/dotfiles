-- General options and settings, organized according to `:options` sections.
local opt = vim.opt

-- ╭─────────────────────────────────────────────╮
-- │ 2. moving around, searching and patterns                                  │
-- ╰─────────────────────────────────────────────╯
opt.incsearch = true -- Show search matches as you type
-- opt.ignorecase = true -- Ignore case in search
opt.ignorecase = false
-- opt.smartcase = true -- Override ignorecase if search contains uppercase
opt.smartcase = false
opt.hlsearch = true

-- Show search count in status line instead of virtual text
vim.opt.shortmess:remove("S") -- Show search count in command line

-- ╭─────────────────────────────────────────────╮
-- │ 4. displaying text                                                        │
-- ╰─────────────────────────────────────────────╯
opt.scrolloff = 4 -- Keep 4 lines above/below cursor
opt.sidescroll = 4
opt.sidescrolloff = 5 -- Keep 4 columns left/right of cursor
opt.wrap = false -- Don't wrap lines
opt.number = true -- Show line numbers
opt.listchars = "tab:▸ ,trail:.,nbsp:_,extends:❯,precedes:❮"
opt.guifont = "MonoLisaCustom Nerd Font:h13:i"

-- ╭─────────────────────────────────────────────╮
-- │ 5. syntax, highlighting and spelling                                      │
-- ╰─────────────────────────────────────────────╯
opt.termguicolors = true -- Enable 24-bit color
opt.cursorline = true -- Highlight current line
opt.spell = true
opt.spelllang = "en_us"

-- ╭─────────────────────────────────────────────╮
-- │ 6. multiple windows                                                       │
-- ╰─────────────────────────────────────────────╯
opt.splitbelow = true -- Open horizontal splits below
opt.splitright = true -- Open vertical splits to the right

-- ╭─────────────────────────────────────────────╮
-- │ 7. multiple tab pages                                                     │
-- ╰─────────────────────────────────────────────╯
opt.showtabline = 2

-- ╭─────────────────────────────────────────────╮
-- │ 9. using the mouse                                                        │
-- ╰─────────────────────────────────────────────╯
opt.mouse = "a" -- Enable mouse support

-- ╭─────────────────────────────────────────────╮
-- │ 12. editing text                                                          │
-- ╰─────────────────────────────────────────────╯
opt.undofile = true -- Enable persistent undo
opt.completeopt = { "menu", "menuone", "noselect" }

-- ╭─────────────────────────────────────────────╮
-- │ 13. tabs and indenting                                                    │
-- ╰─────────────────────────────────────────────╯
opt.tabstop = 2 -- Number of spaces a tab counts for
opt.shiftwidth = 2 -- Number of spaces to use for autoindent
opt.expandtab = true -- Use spaces instead of tabs
opt.softtabstop = 2
opt.smartindent = true

-- ╭─────────────────────────────────────────────╮
-- │ 14. folding                                                               │
-- ╰─────────────────────────────────────────────╯
opt.foldenable = true -- Enable folding
opt.foldmethod = "expr" -- Use expression for folding (works with treesitter)
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
opt.foldlevelstart = 99 -- Start with all folds open

-- ╭─────────────────────────────────────────────╮
-- │ 16. mapping                                                               │
-- ╰─────────────────────────────────────────────╯
opt.timeoutlen = 300 -- Faster key sequence completion

-- ╭─────────────────────────────────────────────╮
-- │ 17. reading and writing files                                             │
-- ╰─────────────────────────────────────────────╯
opt.backup = false
opt.writebackup = false

-- ╭─────────────────────────────────────────────╮
-- │ 18. the swap file                                                         │
-- ╰─────────────────────────────────────────────╯
opt.swapfile = false
opt.updatetime = 250 -- Faster completion

-- ╭─────────────────────────────────────────────╮
-- │ 24. various                                                               │
-- ╰─────────────────────────────────────────────╯
opt.signcolumn = "yes" -- Always show sign column

-- ╭─────────────────────────────────────────────╮
-- │ Custom cursor configuration                                               │
-- ╰─────────────────────────────────────────────╯
opt.guicursor = {
  "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r-cr:hor20-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
}
