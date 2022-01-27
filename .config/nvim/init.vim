scriptencoding utf-8

""===========================================================================""
" init.vim
""===========================================================================""
let s:homebrew_root = substitute(system('brew --prefix'), '\n\+$', '', '')
let g:python_host_prog = s:homebrew_root . '/bin/python2'
let g:python3_host_prog = s:homebrew_root . '/bin/python3'
let g:mapleader = ' '
let g:maplocalleader = ' '

""===========================================================================""
" 0. Load packer stuff first
""===========================================================================""
lua require('plugins')

" Reload after saving this so I can PluginInstall.
" augroup plugins_reloader
"   autocmd!
"   autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source $MYVIMRC
" augroup END


lua << RUST
local ffi = require("ffi")

ffi.cdef [[ void init(void);]]

local project_path = "/Users/sloveless/Development/projects/init.rs"
local suffix = ffi.os == "OSX" and ".dylib" or ".so"
local lib = ffi.load(project_path .. "/target/release/libinit_rs" .. suffix)

lib.init()
RUST

""===========================================================================""
" 4. displaying text
""===========================================================================""
" set breakat=90
" set conceallevel=0

""===========================================================================""
" 5. syntax, highlighting and spelling
""===========================================================================""
" Credit joshdick
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
" check and use tmux's 24-bit color support (see
" < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has('nvim'))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

""===========================================================================""
" 17. mappings
""===========================================================================""
"------------------------------------------------------------------------------
" Alpha character combos
"------------------------------------------------------------------------------
" No more accidentally showing up command window (Use C-f to show it)
" nnoremap q: :q
" nnoremap q: <NOP>

""===========================================================================""
" 20. command line editing
""===========================================================================""
set wildmode=longest,full
set wildmenu

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,*.rbc,*.rbo

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
" set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Ignore simplecov generated coverage docs
set wildignore+=coverage/*

""===========================================================================""
" XX. No :options section
""===========================================================================""
runtime macros/matchit.vim
