scriptencoding utf-8

""===========================================================================""
" init.vim
""===========================================================================""
" Set the global var for this
lua require('turboladen/homebrew').prefix()

" let node_host_path = '/Users/steve.loveless/.nvm/versions/node/v16.16.0/bin'
" let $PATH = node_host_path . ':' . $PATH
" let g:node_host_prog = node_host_path . '/node'
let g:node_host_prog = 'Users/steve.loveless/.nvm/versions/node/v16.16.0/lib/node_modules'
let g:python_host_prog = g:turboladen_homebrew_prefix . '/bin/python2'
let g:python3_host_prog = g:turboladen_homebrew_prefix . '/bin/python3'
let g:mapleader = ' '
let g:maplocalleader = ' '

let g:loaded_perl_provider = 0

lua << RUST
local ffi = require("ffi")

ffi.cdef [[ void init(void); ]]

local project_path = vim.env.HOME .. "/Development/projects/init.rs"
local suffix = ffi.os == "OSX" and ".dylib" or ".so"

local lib = ffi.load(project_path .. "/target/release/libinit_rs" .. suffix)
-- local lib = ffi.load(project_path .. "/target/debug/libnvim_rust_init" .. suffix)
lib.init()
RUST

""===========================================================================""
" 0. Load packer stuff first
""===========================================================================""
lua require('plugins')
lua require('impatient')

" Reload after saving this so I can PluginInstall.
" augroup plugins_reloader
"   autocmd!
"   autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source $MYVIMRC
" augroup END

""===========================================================================""
" 4. displaying text
""===========================================================================""
" set breakat=90
" set conceallevel=0

set guifont=JetBrainsMono\ Nerd\ Font:h14
colorscheme kanagawa
" colorscheme codeschool
" colorscheme edge
" colorscheme everforest
" colorscheme falcon
" colorscheme github_dark_default
" colorscheme kosmikoa
" colorscheme kuroi
" colorscheme material
" colorscheme nightfox
" colorscheme nordbuddy
" colorscheme uwu
" colorscheme nightfox

"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

""===========================================================================""
" 17. mappings
""===========================================================================""
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

""===========================================================================""
" YY. Plugin options that must be here.
""===========================================================================""

"" https://www.reddit.com/r/neovim/comments/sdoljj/made_a_super_small_function_to_create_a_note/
function! Spawn_note_window() abort
  let path = "~/Development/notes/"
  let file_name = path.strftime("note-%d-%m-%y.md")

  " Empty buffer
  let buf = nvim_create_buf(v:false, v:true)

  " Get current UI
  let ui = nvim_list_uis()[0]

  " Dimension
  let l:width = (ui.width/2)
  let l:max_width = 80
  if l:width > l:max_width
    let l:width = l:max_width
  endif

  let height = (ui.height/2)
  " Options for new window
  let opts = {'relative': 'editor',
              \ 'width': l:width,
              \ 'height': height,
              \ 'col': (ui.width - l:width)/2,
              \ 'row': (ui.height - height)/2,
              \ 'anchor': 'NW',
              \ 'style': 'minimal',
              \ 'border': 'single',
              \ }
  " Spawn window
  let win = nvim_open_win(buf, 1, opts)

  let column = l:max_width

  " Now we can actually open or create the note for the day?
  if filereadable(expand(file_name))
    execute 'e '.fnameescape(file_name)
    execute 'set textwidth='.column
    execute 'set colorcolumn='.column
    execute 'norm Go'
    execute 'norm zz'
  " execute "startinsert"
  else
    execute 'e '.fnameescape(file_name)
    let column = 80
    execute 'set textwidth='.column
    execute 'set colorcolumn='.column
    execute 'norm Gi# Notes for '.strftime('%d-%m-%y')
    execute 'norm G2o'
    execute 'norm Gi- '
    execute 'norm zz'
    " execute "startinsert"
  endif
endfunction

nmap <silent> <leader>n :call Spawn_note_window() <CR>

" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
" nmap        s   <Plug>(vsnip-select-text)
" xmap        s   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        S   <Plug>(vsnip-cut-text)
