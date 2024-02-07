--          ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--          ┃            Organized according to `:options`            ┃
--          ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

--  ╭──────────────────────────────────────────╮
--  │ 2. moving around, searching and patterns │
--  ╰──────────────────────────────────────────╯

--  ╭────────────────────╮
--  │ 4. displaying text │
--  ╰────────────────────╯
vim.opt.scrolloff = 2
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.sidescroll = 4
vim.opt.sidescrolloff = 5
vim.opt.cmdheight = 2
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:.,nbsp:_,extends:❯,precedes:❮"
vim.opt.number = true

vim.opt.guifont = 'MonoLisaCustom Nerd Font:h13:i'

-- ╭──────────────────────────────────────╮
-- │ 5. syntax, highlighting and spelling │
-- ╰──────────────────────────────────────╯
vim.opt.synmaxcol = 250
vim.opt.termguicolors = true
vim.opt.cursorcolumn = false -- this defaults to false, but is getting set somewhere
-- vim.opt.cursorline = true
-- vim.opt.colorcolumn = "80,120"

vim.opt.spell = true
vim.opt.spelllang = "en_us"

--  ╭─────────────────────╮
--  │ 6. Multiple windows │
--  ╰─────────────────────╯
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"

--  ╭───────────────────────╮
--  │ 7. multiple tab pages │
--  ╰───────────────────────╯
vim.opt.showtabline = 2

--  ╭─────────────╮
--  │ 8. terminal │
--  ╰─────────────╯
--  ╭─────────────────────╮
--  │  9. using the mouse │
--  ╰─────────────────────╯
--  ╭───────────────────────╮
--  │ 10. Messages and info │
--  ╰───────────────────────╯
vim.opt.shortmess:append('c')

--  ╭────────────────────╮
--  │ 11. Selecting text │
--  ╰────────────────────╯

--  ╭──────────────────╮
--  │ 12. Editing text │
--  ╰──────────────────╯
-- vim.opt.undofile = true
vim.opt.completeopt = "menu,menuone,noselect"

--  ╭────────────────────────╮
--  │ 13. Tabs and indenting │
--  ╰────────────────────────╯
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.smartindent = true

--  ╭─────────────╮
--  │ 14. Folding │
--  ╰─────────────╯
vim.opt.foldenable = false

--  ╭───────────────╮
--  │ 15. diff mode │
--  ╰───────────────╯
--  ╭───────────────╮
--  │ 16. mapping   │
--  ╰───────────────╯
--  ╭───────────────────────────────╮
--  │ 17. reading and writing files │
--  ╰───────────────────────────────╯
vim.opt.writebackup = false

--  ╭───────────────────╮
--  │ 18. the swap file │
--  ╰───────────────────╯
vim.opt.swapfile = false

--  ╭──────────────────────────╮
--  │ 19. command line editing │
--  ╰──────────────────────────╯
vim.opt.history = 300
vim.opt.wildmode = { 'longest', 'full' }
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
vim.opt.wildmenu = true

--  ╭──────────────────────────────────╮
--  │  20. executing external commands │
--  ╰──────────────────────────────────╯
--  ╭────────────────────────────────────────────────────╮
--  │  21. running make and jumping to errors (quickfix) │
--  ╰────────────────────────────────────────────────────╯
vim.opt.grepprg = "rg --vimgrep --files"

--  ╭────────────────────────╮
--  │  22. language specific │
--  ╰────────────────────────╯
--  ╭────────────────────────────╮
--  │  23. multi-byte characters │
--  ╰────────────────────────────╯
--  ╭──────────────╮
--  │  24. various │
--  ╰──────────────╯
vim.opt.signcolumn = "yes"
