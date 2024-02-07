-- ╭───────────────────────────────────────────────────╮
-- │ 0. Load special things before plugins stuff first │
-- ╰───────────────────────────────────────────────────╯
vim.opt.termguicolors = true

--  ╭──────────────────────────────────────────╮
--  │ 2. moving around, searching and patterns │
--  ╰──────────────────────────────────────────╯
-- vim.opt.smartcase = true

--  ╭────────────────────╮
--  │ 4. displaying text │
--  ╰────────────────────╯
vim.opt.breakindent = true
vim.opt.cmdheight = 2
-- vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:.,nbsp:_,extends:❯,precedes:❮"
vim.opt.number = true
vim.opt.scrolloff = 2
vim.opt.showtabline = 2

-- set guifont=MonoLisaCustom\ Nerd\ Font:h13:i
vim.opt.guifont = 'MonoLisaCustom Nerd Font:h13:i'

-- ╭──────────────────────────────────────╮
-- │ 5. syntax, highlighting and spelling │
-- ╰──────────────────────────────────────╯
vim.opt.colorcolumn = "80,120"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.synmaxcol = 250
vim.opt.tabstop = 2
vim.opt.termguicolors = true

--  ╭─────────────────────╮
--  │ 6. Multiple windows │
--  ╰─────────────────────╯
vim.opt.splitbelow = true
vim.opt.splitright = true

--  ╭───────────────────────╮
--  │ 7. multiple tab pages │
--  ╰───────────────────────╯
--  ╭─────────────╮
--  │ 8. terminal │
--  ╰─────────────╯
--  ╭─────────────────────╮
--  │  9. using the mouse │
--  ╰─────────────────────╯
--  10. messages and info

--  ╭───────────────────────╮
--  │ 10. Messages and info │
--  ╰───────────────────────╯
vim.opt.shortmess:append('c')

--  ╭────────────────────╮
--  │ 11. Selecting text │
--  ╰────────────────────╯
-- vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.undofile = true

--  ╭──────────────────╮
--  │ 12. Editing text │
--  ╰──────────────────╯
--  ╭────────────────────────╮
--  │ 13. Tabs and indenting │
--  ╰────────────────────────╯
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

--  ╭─────────────╮
--  │ 14. Folding │
--  ╰─────────────╯
vim.opt.foldenable = false

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
