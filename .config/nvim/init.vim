scriptencoding utf-8

""===========================================================================""
" init.vim
""===========================================================================""
let s:homebrew_root = substitute(system('brew --prefix'), '\n\+$', '', '')
let g:python_host_prog = s:homebrew_root . '/bin/python2'
let g:python3_host_prog = s:homebrew_root . '/bin/python3'
let g:mapleader = ' '
let g:maplocalleader = ' '

lua << RUST
local ffi = require("ffi")

ffi.cdef [[ void init(void); ]]

local project_path = "/Users/steve.loveless/Development/projects/init.rs"
local suffix = ffi.os == "OSX" and ".dylib" or ".so"

local lib = ffi.load(project_path .. "/target/release/libinit_rs" .. suffix)
-- local lib = ffi.load(project_path .. "/target/debug/libnvim_rust_init" .. suffix)
lib.init()
RUST

""===========================================================================""
" 0. Load packer stuff first
""===========================================================================""
lua require('plugins')
lua require('mappings')

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
    execute "e ".fnameescape(file_name)
    execute "set textwidth=".column
    execute "set colorcolumn=".column
    execute "norm Go"
    execute "norm zz"
  " execute "startinsert"
  else
    execute "e ".fnameescape(file_name)
    let column = 80
    execute "set textwidth=".column
    execute "set colorcolumn=".column
    execute "norm Gi# Notes for ".strftime("%d-%m-%y")
    execute "norm G2o"
    execute "norm Gi- " 
    execute "norm zz"
    " execute "startinsert"
  endif
endfunction

nmap <silent> <leader>n :call Spawn_note_window() <CR>
