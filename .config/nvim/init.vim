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

" Note to self: When I switched to nvim-oxi, I switched to follow its
" convention for loading the .so: put it in a dir that's in rtp, letting us
" load that by simply doing:
lua require('init_rs')

""===========================================================================""
" 0. Load packer stuff first
""===========================================================================""
augroup packer_user_config
  autocmd!
  " autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  autocmd BufWritePost plugins.lua PackerCompile
augroup end

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

set guifont=MonoLisaCustom\ Nerd\ Font:h13:i

" colorscheme kanagawa
colorscheme nightfox
" colorscheme everforest
" colorscheme material
" colorscheme falcon
" colorscheme github_dark_default
" colorscheme kosmikoa
" colorscheme kuroi
" colorscheme nordbuddy
" colorscheme uwu

"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

""===========================================================================""
" 17. mappings
"     Trying out these options before deciding to keep them around (and move
"     to their proper spot).
""===========================================================================""
autocmd BufRead Tiltfile setf=tiltfile

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
