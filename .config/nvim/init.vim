scriptencoding utf-8

""===========================================================================""
" init.vim
""===========================================================================""
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:mapleader = ' '

""===========================================================================""
" 0. Load packer stuff first
""===========================================================================""
lua require('plugins')

" Reload after saving this so I can PluginInstall.
augroup plugins_reloader
  autocmd!
  autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source $MYVIMRC
augroup END

""===========================================================================""
" 1. important
""===========================================================================""
set pastetoggle=<F9> " For Mac

""===========================================================================""
" 2. moving around, searching and patterns
"===========================================================================""
set noignorecase  " searches are case insensitive...
set smartcase     " ... unless they contain at least one capital letter

""===========================================================================""
" 4. displaying text
""===========================================================================""
set scrolloff=3
set wrap                  " Wrap long lines
" set whichwrap+=<,>,h,l
set linebreak
set breakat=90
set number
set list          " Show invisibles/whitespace
set listchars=tab:▸\ ,trail:·,nbsp:_,extends:❯,precedes:❮
set cmdheight=2 " More room for RLS info

set laststatus=2
set showtabline=2

set conceallevel=0

"tabline
if exists('+showtabline')
  set tabline=%!turboladen#MyTabLine()
endif

""===========================================================================""
" 5. syntax, highlighting and spelling
""===========================================================================""
" Detect file type and syntax
syntax enable

" Turn off syntax over X chars in a line
set synmaxcol=250

set spell

if exists('+spelllang')
  set spelllang=en_us
endif

set colorcolumn=80,120    " Show rulers
set hlsearch              " highlight matches
set cursorline

" Credit joshdick
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
" check and use tmux's 24-bit color support (see
" < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has('nvim'))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has('termguicolors'))
  set termguicolors
endif

" colorscheme humanoid
colorscheme kuroi
" colorscheme spacecamp
" colorscheme one
" colorscheme seti
" colorscheme Tomorrow-Night
" colorscheme Tomorrow
" colorscheme Tomorrow-Night-Eighties
" let g:onedark_terminal_italics = 1
" colorscheme onedark
" let g:seoul256_background = 234
" colorscheme seoul256
" set background=dark
" set termguicolors

function! StatusLine(...)
  return crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill')
        \ . get(g:, 'coc_status', '')
        \ . '%='
        \ . crystalline#left_sep('', 'Fill') . ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
endfunction
let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'onedark'

""===========================================================================""
" 6. multiple windows
""===========================================================================""
" Open new split window below.
set splitbelow

" Open new vsplit window to the right.
set splitright

""===========================================================================""
" 11. messages and info
""===========================================================================""
set shortmess+=c

""===========================================================================""
" 12. selecting text
""===========================================================================""
" https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
set clipboard=unnamed

""===========================================================================""
" 13. editing text
""===========================================================================""
" More info for completion.
" set completeopt+=longest,preview
set completeopt+=menuone,noinsert,noselect

" https://tomjwatson.com/blog/vim-tips/
set undodir=~/.config/nvim/undodir
set undofile

""===========================================================================""
" 14. tabs and indenting
""===========================================================================""
set smartindent
set autoindent

" Set default spacing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

""===========================================================================""
" 15. folding
""===========================================================================""
" set foldmethod=indent
" set foldlevelstart=4
" set foldnestmax=10      " 10 nested fold max
set nofoldenable

" from https://github.com/nvim-treesitter/nvim-treesitter#folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

""===========================================================================""
" 17. mappings
""===========================================================================""
"--------------------------------------
" <Leader> maps
"--------------------------------------
" Since I remap <C-l> (default redraw command), add a mapping for that.
nnoremap <leader>dr :redraw!<CR>

" eDIT MY vIMRC FILE
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>ep :vsplit ~/.config/nvim/lua/plugins.lua<CR>

" Reload all the things!
nnoremap <leader>v :source $MYVIMRC<CR>

"------------------------------------------------------------------------------
" Ctrl- combos
"------------------------------------------------------------------------------
" Save some ring-finger key strokes
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
imap <C-BS> <C-W>

"------------------------------------------------------------------------------
" Alpha character combos
"------------------------------------------------------------------------------
" Disable Ex mode
nnoremap Q <NOP>

" After block yank and paste, move cursor to the end of operated text
" Also, don't copy over-pasted text in visual mode
" vnoremap y y`]
" vnoremap p "_dP`]
" nnoremap p p`]

" No more accidentally showing up command window (Use C-f to show it)
" nnoremap q: :q
nnoremap q: <NOP>

" Split a line and remove whitespace from old line.
" https://www.reddit.com/r/vim/comments/3g8y3r/finally_hacked_together_a_quick_split_line/ctw4b0i
nnoremap S i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>

""===========================================================================""
" 18. reading and writing files
""===========================================================================""
set nobackup
set nowritebackup

""===========================================================================""
" 19. the swap file
""===========================================================================""
set noswapfile
set updatetime=300    " for coc.vim

""===========================================================================""
" 20. command line editing
""===========================================================================""
" Only remember this many commands
set history=300

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

" Ignore RubyMine stuff
set wildignore+=.idea/*

" Ignore Rust stuff
" set wildignore+=/target

""===========================================================================""
" 21. executing external commands
""===========================================================================""

""===========================================================================""
" 22. running make and jumping to errors
""===========================================================================""
set grepprg=rg\ --vimgrep\ --files

""===========================================================================""
" 23. language specific
""===========================================================================""

""===========================================================================""
" 24. multi-byte characters
""===========================================================================""

""===========================================================================""
" 25. various
""===========================================================================""
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number " only works with neovim >= 0.5

""===========================================================================""
" XX. No :options section
""===========================================================================""
runtime macros/matchit.vim

augroup vimrc
  autocmd!

  " Delete the buffer once I'm done with it.
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Open grep commands, specifically Ggrep, in QuickFix
  " autocmd QuickFixCmdPost *grep* cwindow

 au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
augroup END

augroup FTCheck
  autocmd BufNewFile,BufRead *.jbuilder set ft=ruby
  autocmd BufNewFile,BufRead *.rs.hbs setlocal ft=rust.handlebars
augroup END

augroup FTOptions " {{{2
  autocmd!

  autocmd FileType dirvish setlocal nospell
  autocmd FileType haproxy setlocal commentstring=#\ %s
  autocmd FileType help nnoremap  q :q
  autocmd FileType html setlocal softtabstop=4
  autocmd FileType qf setlocal nospell

  autocmd FileType vim-plug setlocal nospell
  autocmd FileType vimwiki setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab cursorcolumn indentkeys-=<:>
  autocmd FileType zsh setlocal ts=2 sts=2 sw=2 expandtab
augroup END "}}}2

""===========================================================================""
" YY. Plugin options that must be here.
""===========================================================================""
