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
set foldlevelstart=10
set foldnestmax=10      " 10 nested fold max

" from https://github.com/nvim-treesitter/nvim-treesitter#folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

""===========================================================================""
" 16. diff mode
""===========================================================================""

""===========================================================================""
" 17. mappings
""===========================================================================""
" https://www.reddit.com/r/vim/comments/6h0dy7/which_autoclosing_plugin_do_you_use/diujtbd/
" inoremap (; (<CR>);<C-c>O
" inoremap (, (<CR>),<C-c>O
" inoremap {; {<CR>};<C-c>O
" inoremap {, {<CR>},<C-c>O
" inoremap [; [<CR>];<C-c>O
" inoremap [, [<CR>],<C-c>O

"--------------------------------------
" Leader commands
"
" Listed first where commands pertain to plugins, then alphabetically (where
" they're for things I've defined.
"--------------------------------------

"-----
" BufOnly.vim
" Close buffers
"-----
nnoremap <leader>q :BufOnly<CR>

"-----
" Plug 'tpope/vim-dispatch'
"-----
" nnoremap <leader>b :Dispatch bundle install<CR>

"-----
" skwp/greplace.vim
"-----
" nnoremap <leader>/ :Gsearch<SPACE>
" nnoremap <leader>\ :Greplace<CR>

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

"-----
" janko-m/vim-test
"-----
" augroup VimTest
"   autocmd FileType rust nmap <silent> <leader>s :tab RustTest<CR>
" augroup END

nnoremap <silent> <leader>t :TestFile<CR>
nnoremap <silent> <leader>l :TestLast<CR>

nmap <silent> <leader>] <Plug>(ale_next_wrap)
nmap <silent> <leader>[ <Plug>(ale_previous_wrap)

"--------------------------------------
" <Leader>A-G
"--------------------------------------

" Close a buffer but don't close the window
nnoremap <silent><leader>bc :bprevious<CR>:bdelete #<CR>
nnoremap <silent><leader>bn :bnext<CR>
nnoremap <silent><leader>bp :bprevious<CR>

" Since I remap <C-l> (default redraw command), add a mapping for that.
nnoremap <leader>dr :redraw!<CR>

" eDIT MY vIMRC FILE
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>ep :vsplit ~/.config/nvim/plugins.vim<CR>

"--------------------------------------
" <Leader>H-L
"--------------------------------------
" noremap <leader>h :call turboladen#SetUpTurboladenDocs()<CR>

" bind r to grep word under cursor
nnoremap <leader>r :FzfRg <C-R><C-W><CR>

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
nnoremap <leader>w :call turboladen#StripTrailingWhitespaces()<CR>

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

" Center screen on Down/Up jumping
" noremap <C-d> <C-d>zz
" noremap <C-u> <C-u>zz
" noremap <C-D> :call smoothie#downwards()<CR>zz
" noremap <C-U> :call smoothie#upwards()<CR>zz

"------------------------------------------------------------------------------
" Alpha character combos
"------------------------------------------------------------------------------
" Reindent whole file
nnoremap <leader>= :call turboladen#KeepJumps("gg=G")<CR>

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
" set grepprg=rg\ --files\ --vimgrep
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
set gdefault

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=number " only works with neovim >= 0.5
set signcolumn=yes

" Show (git) signs next to numbers instead of on top of numbers
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
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

augroup FTCheck
  autocmd BufNewFile,BufRead *.jbuilder set ft=ruby
augroup END

augroup FTOptions " {{{2
  autocmd FileType dirvish setlocal nospell
  autocmd FileType haproxy setlocal commentstring=#\ %s
  autocmd FileType help nnoremap  q :q
  autocmd FileType html setlocal softtabstop=4
  autocmd FileType markdown setlocal textwidth=100
  autocmd FileType markdown setlocal colorcolumn=100
  autocmd FileType markdown setlocal formatoptions-=l
  autocmd FileType qf setlocal nospell

  autocmd FileType ruby setlocal foldexpr=turboladen#RubyMethodFold(v:lnum)
  autocmd FileType ruby setlocal foldmethod=expr
  autocmd FileType ruby nnoremap <leader>b :Dispatch bundle install<CR>
  autocmd FileType ruby nmap <silent> <leader>r :!bin/rubocop -a %<CR>
  " Output the command for manually running RSpec for that line.
  autocmd FileType ruby nnoremap <leader>m :call turboladen#RSpecCommandForManualRunning()<CR>
  " puts the caller
  autocmd FileType ruby nnoremap <leader>x oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

  autocmd FileType rust setlocal colorcolumn=100
  autocmd FileType rust setlocal foldmethod=expr
  autocmd FileType rust setlocal foldexpr=GetRustFold(v:lnum)
  " autocmd FileType rust nmap <silent> <leader>s :TestNearest<CR>
  " autocmd FileType rust inoremap S( Some()<esc>ha
  autocmd FileType rust nnoremap <leader>cc :Dispatch cargo check --all-features<CR>
  autocmd FileType rust nmap <silent> gO :CocCommand rust-analyzer.openDocs<cr>

  autocmd FileType vim-plug setlocal nospell
  autocmd FileType vimwiki setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab cursorcolumn indentkeys-=<:>
  autocmd FileType zsh setlocal ts=2 sts=2 sw=2 expandtab

  autocmd BufNewFile,BufRead *.rs.hbs setlocal ft=rust.handlebars
augroup END "}}}2

augroup coc
" Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

""===========================================================================""
" YY. Plugin options that must be here.
""===========================================================================""
"-------------------------
" ale
"-------------------------
" let g:ale_cursor_detail = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_disable_lsp = 1

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

let g:ale_linters = {
  \ 'markdown': ['proselint', 'writegood'],
  \ 'vim': ['vint'],
  \ }

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'ruby': ['rubocop'],
  \ 'rust': ['rustfmt']
  \ }

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
let g:coc_node_path = '/usr/local/bin/node'

" coc-dictionary: Words from files in &dictionary.
" coc-git: Somewhat replaces gitgutter; kinda depends on vim-fugitive.
" coc-html: HTML language server.
" coc-lists: Some basic list sources
" coc-prettier: Code reformatting--initially got for markdown
"
let g:coc_global_extensions = [
  \ 'coc-dictionary',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-lists',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-rust-analyzer',
  \ 'coc-solargraph',
  \ 'coc-snippets',
  \ 'coc-toml',
  \ 'coc-yaml'
\ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" https://kimpers.com/vim-intelligent-autocompletion/
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
" nmap <silent> <leader>] <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [G <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]G <Plug>(coc-diagnostic-next-error)
nmap <silent> g= <Plug>(coc-format)

" Remap for rename current word
nmap <silent> rn <Plug>(coc-rename)
nmap gA <Plug>(coc-codeaction-line)
vmap gA <Plug>(coc-codeaction-selected)
nmap gB <Plug>(coc-codeaction-cursor)
vmap gB <Plug>(coc-codeaction)
nmap gF <Plug>(coc-fix-current)
nmap <silent> gR <Plug>(coc-refactor)

" Show all diagnostics.
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

nnoremap <leader>/ :CocSearch<SPACE>

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

"--
" For coc-snippets
"--
" https://github.com/neoclide/coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

"-------------------------
" neoclide/coc-git
"-------------------------
set signcolumn=yes
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)

"-------------------------
" neoclide/coc-prettier
"-------------------------
command! -nargs=0 Prettier :CocCommand prettier.formatFile

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

"-------------------------
" elzr/vim-json
"-------------------------
let g:vim_json_syntax_conceal = 0

"-------------------------
" iamcco/vim-language-server
"-------------------------
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

"-------------------------
" plasticpoy/vim-markdown
"-------------------------
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rust=rust']
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2

"-------------------------
" jremmen/vim-ripgrep
"-------------------------
let g:rg_highlight = 1

"-------------------------
" 'psliwka/vim-smoothie'
"-------------------------
let g:smoothie_enabled = 1
let g:smoothie_no_default_mappings = 0

"-------------------------
" janko-m/vim-test
"-------------------------
let g:test#strategy = 'dispatch'
let g:test#preserve_screen = 1
let test#enabled_runners = ['rust#cargotest', 'ruby#rspec']

"-------------------------
" junegunn/goyo.vim
"-------------------------
let g:goyo_width = 101

"-------------------------
" nvim-treesitter
"-------------------------
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
  " ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  " highlight = {
    " enable = { "bash", "c", "cpp", "html", "javascript", "json", "lua", "python", "rust", "ruby", "toml", "typescript" },
  " },
" }
" EOF

"-------------------------
" liuchengxu/vim-clap
"-------------------------
let g:clap_layout = { 'relative': 'editor' }
