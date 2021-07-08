scriptencoding utf-8

""===========================================================================""
" .vimrc
"
"  Partially borrowed from:
"    * http://mixandgo.com/blog/vim-config-for-rails-ninjas
"    * http://amix.dk/vim/vimrc.html
"
" Search settings, stolen from carlhuda/janus.
"
" https://github.com/carlhuda/janus/blob/master/janus/vim/core/before/plugin/settings.vim
"
""===========================================================================""
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:mapleader = ' '

set runtimepath+=/usr/local/opt/fzf

""===========================================================================""
" 0. Load vim-plug stuff first
""===========================================================================""
source ~/.config/nvim/plugins.vim

""===========================================================================""
" 1. important
""===========================================================================""
set pastetoggle=<F9> " For Mac

""===========================================================================""
" 2. moving around, searching and patterns
"===========================================================================""
set noignorecase  " searches are case insensitive...
set smartcase     " ... unless they contain at least one capital letter

map <leader>f <Plug>(easymotion-prefix)
" map <leader>f :HopChar1<CR>

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
"tabline
if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%1*' : '%2*')
             let s .= ' '
             let s .= '|'. i . ')'
             let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             " let file = fnamemodify(file, ':p:t')
             let file = fnamemodify(file, ':f')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             let s .= ' '
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif

""===========================================================================""
" 5. syntax, highlighting and spelling
""===========================================================================""
" Detect file type and syntax
syntax on
syntax sync fromstart

" Turn off syntax over X chars in a line
set synmaxcol=250

set spell

if exists('+spelllang')
  set spelllang=en_us
endif

set colorcolumn=80,120    " Show rulers
set hlsearch              " highlight matches
set cursorline

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
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

" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"       \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"       \,sm:block-blinkwait175-blinkoff150-blinkon175
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
" 7. multiple tab pages
""===========================================================================""

""===========================================================================""
" 8. terminal
""===========================================================================""

""===========================================================================""
" 9. using the mouse
""===========================================================================""

""===========================================================================""
" 10. printing
""===========================================================================""

""===========================================================================""
" 11. messages and info
""===========================================================================""

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
" set completeopt+=menuone,noinsert,noselect

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

" from https://github.com/nvim-treesitter/nvim-treesitter#folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

""===========================================================================""
" 16. diff mode
""===========================================================================""

""===========================================================================""
" 17. mappings
""===========================================================================""

"--------------------------------------
" Leader commands
"
" Listed first where commands pertain to plugins, then alphabetically (where
" they're for things I've defined.
"--------------------------------------

"-----
" BufOnly.vim
"-----
" Close all buffers except the current one
nnoremap <leader>q :BufOnly<CR>

"-----
" Plug 'tpope/vim-dispatch'
"-----

"-----
" tpope/vim-fugitive.
" Follows mappings for the zsh git plugin.
"-----
" noremap <leader>ga :Gwrite<CR>
" noremap <leader>gbl :Gblame<CR>
" noremap <leader>gbr :Gbrowse<CR>
" noremap <leader>gc :Gcommit<CR>
noremap <leader>gd :Gvdiff<CR>
" noremap <leader>ggp :Gpush<CR>
" noremap <leader>ggr :Ggrep<SPACE>
" noremap <leader>gi :Git<SPACE>
" noremap <leader>glg :Glog<CR>
" noremap <leader>gll :Gpull<CR>
" noremap <leader>gm :Gmove<SPACE>
" noremap <leader>gr :Gremove<CR>
noremap <leader>gs :Git<CR>

"--------------------------------------
" <Leader>A-G
"--------------------------------------

" Since I remap <C-l> (default redraw command), add a mapping for that.
nnoremap <leader>dr :redraw!<CR>

" eDIT MY vIMRC FILE
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>ep :vsplit ~/.config/nvim/plugins.vim<CR>

"--------------------------------------
" <Leader>H-L
"--------------------------------------
" bind r to grep word under cursor
" nnoremap <leader>r :FzfRg <C-R><C-W><CR>

"--------------------------------------
" <Leader>L-R
"--------------------------------------
" Do a TODO search
nnoremap <silent> <leader>o :FzfRg TODO<CR>

"--------------------------------------
" <Leader>S-V
"--------------------------------------
" Reload all the things!
nnoremap <leader>v :source $MYVIMRC<CR>

"--------------------------------------
" <Leader>W-Z
"--------------------------------------

"-------------------------------------------------------------------------------
" Other remappings
"-------------------------------------------------------------------------------

"--------------------------------------
" F-keys
"--------------------------------------

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
set grepprg=rg\ --vimgrep

""===========================================================================""
" 23. language specific
""===========================================================================""

""===========================================================================""
" 24. multi-byte characters
""===========================================================================""

""===========================================================================""
" 25. various
""===========================================================================""
" Default search/replace to work globally.
" set gdefault

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=number " only works with neovim >= 0.5
set signcolumn=yes

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

"-------------------------
" fzf
" https://github.com/junegunn/dotfiles/blob/da378217ad008d422bc5b577802cad237a2930e1/vimrc#L1197
"-------------------------
let $FZF_DEFAULT_COMMAND='rg --files --vimgrep'
let $FZF_DEFAULT_OPTS='--layout=reverse --inline-info --border=horizontal --height=5'
"
" set runtimepath+=/usr/local/opt/fzf
let g:fzf_command_prefix = 'Fzf'

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" nnoremap <silent> <leader><leader> :FzfGitFiles<CR>
nnoremap <silent> <leader><leader> :FzfFiles<CR>
" nnoremap <silent> <leader><leader> :Clap files<CR>
" nnoremap <silent> <leader><leader> :FzfSearch<CR>
nnoremap <silent> <leader><CR> :FzfBuffers<CR>
" nnoremap <silent> <leader><CR> :Clap buffers<CR>
" nnoremap <silent> <leader><C-m> :Maps<CR>

nnoremap <leader>. :Rg<SPACE>
" nnoremap <leader>s :Clap grep<CR>
let g:rg_command = 'rg --vimgrep --ignore-vcs'

"-------------------------
" coc.vim
"-------------------------

"------------------------
" junegunn/limelight.vim
"------------------------
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

"-------------------------
" tmuxline.vim
"-------------------------
let g:tmuxline_preset = 'nightly_fox'
" let g:tmuxline_powerline_separators = 0

"-------------------------
" timonv/vim-cargo
"-------------------------
let g:cargo_command = 'Dispatch cargo {cmd}'

"-------------------------
" idanarye/vim-casetrate
"-------------------------
let g:casetrate_leader = '\c'

"-------------------------
" airblade/vim-gitgutter
"-------------------------
" let g:gitgutter_sign_added = '✚'
" let g:gitgutter_sign_modified = '✹'
" let g:gitgutter_sign_removed = '✖'
" let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_modified_removed = '⟪⟫'
" let g:gitgutter_sign_modified_removed = '⇄'
" navigate chunks of current buffer
