scriptencoding utf-8

""------------------------------------------------""
"" vim-plug setup
""------------------------------------------------""
" vim-plug start
call plug#begin('~/.config/nvim/plugged')

""===========================================================================""
" 0.
""===========================================================================""
" Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

""----------------------------------------------------------------------------
" UI tweaks
""----------------------------------------------------------------------------
" Enhanced terminal integration for Vim
Plug 'wincent/terminus'

" vim-signature is a plugin to place, toggle and display marks.
Plug 'kshenoy/vim-signature'

" Vim plugin that shows keybindings in popup
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'

" Plug 'joeytwiddle/sexy_scroller.vim'
" Plug 'yuttie/comfortable-motion.vim'

""===========================================================================""
" 2. moving around, searching and patterns
""===========================================================================""
Plug 'junegunn/fzf.vim'

" Use RipGrep in Vim and display results in a quickfix list
Plug 'jremmen/vim-ripgrep'

" Project-wide search/replace with :Gsearch and :Greplace
" Plug 'skwp/greplace.vim'

" An ack/ag/pt/rg powered code search and view tool, takes advantage of Vim 8's
" power to support asynchronous searching, and lets you edit file in-place with
" Edit Mode.
Plug 'dyng/ctrlsf.vim'

" combine with netrw to create a delicious salad dressing.
Plug 'tpope/vim-vinegar'

" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Directory viewer for Vim
Plug 'justinmk/vim-dirvish' | Plug 'kristijanhusak/vim-dirvish-git'

Plug 'airblade/vim-gitgutter'

" extended % matching for HTML, LaTeX and many other languages
Plug 'tmhedberg/matchit'

" Create your own text objects | A custom text object for selecting ruby
" blocks.
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Change code right in the quickfix window
Plug 'stefandtw/quickfix-reflector.vim'

" Modern performant generic finder and dispatcher for Vim and NeoVim
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

" Vim motion on speed!
Plug 'easymotion/vim-easymotion'
" Plug 'phaazon/hop.nvim'

""===========================================================================""
" 5. syntax, highlighting and spelling
""===========================================================================""
" Color schema
Plug 'humanoid-colors/vim-humanoid-colorscheme'

" Color scheme
Plug 'aonemd/kuroi.vim'

" Color Scheme
Plug 'trusktr/seti.vim'

" Adaptation of one-light and one-dark colorschemes for Vim
Plug 'rakr/vim-one'

" 🔭 Vim colors for the final frontier.
Plug 'jaredgorski/SpaceCamp'

" Hyperfocus-writing in Vim
Plug 'junegunn/limelight.vim'

" Show vertical line for indentation level
" Plug 'Yggdroot/indentLine'

" Toast! A colorful, medium-contrast theme with full Vim and Neovim support,
" true color and 256-color support, and automatic light and dark variants. Easy
" to read without frying your retinae.
Plug 'jsit/toast.vim'

" Define a different filetype syntax on regions of a buffer
" Plug 'vim-scripts/SyntaxRange'

""===========================================================================""
" 6. multiple windows
""===========================================================================""
" Delete all the buffers except the current/named buffer
Plug 'vim-scripts/BufOnly.vim'

""===========================================================================""
" 11. messages and info
""===========================================================================""

""===========================================================================""
" 12. selecting text
""===========================================================================""
" It's called vim-visual-multi in analogy with visual-block, but the plugin
" works mostly from normal mode.
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

""===========================================================================""
" 13. editing text
""===========================================================================""
" wisely add 'end' in ruby, endfucntion/endif/more in vimscript, etc.
Plug 'tpope/vim-endwise'

" Closes brackets. Perfect companion to vim-endwise. Basically, a more
" conservative version of auto-pairs that only works when you press Enter.
Plug 'rstacruz/vim-closer'

" comment stuff out
Plug 'tpope/vim-commentary'

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Adds gS and gJ to split/join code blocks.
Plug 'AndrewRadev/splitjoin.vim'

" Easy text exchange operator
Plug 'tommcdo/vim-exchange'

" Protect against weird unicode copy/paste
Plug 'vim-utils/vim-troll-stopper'

" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" For case swapping
Plug 'idanarye/vim-casetrate'

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

""===========================================================================""
" 15. folding
""===========================================================================""
" Speed up Vim by updating folds only when called-for
" Plug 'Konfekt/FastFold'

""===========================================================================""
" 21. executing external commands
""===========================================================================""
" Asynchronous build and test dispatcher. Used for running specs in a separate
" tmux pane.
Plug 'tpope/vim-dispatch'

" Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-eunuch'

" run your tests at the speed of thought
Plug 'janko-m/vim-test'

""===========================================================================""
" 22. running make and jumping to errors
""===========================================================================""

""===========================================================================""
" 23. language specific
""===========================================================================""

"----------------
" CSS
"----------------
" Cutting-edge vim css syntax file
" Plug 'JulesWang/css.vim', { 'for': 'css' }

"----------------
" dockerfile
"----------------
" Plug 'docker/docker', { 'for': 'dockerfile' }

"----------------
" Elixir
"----------------
" Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
" Plug 'avdgaag/vim-phoenix', { 'for': ['elixir', 'eelixir'] }

"----------------
" Elm
"----------------
" Plug 'elmcast/elm-vim', { 'for': 'elm' }

"----------------
" Git
"----------------
" Vim Git runtime files
Plug 'tpope/vim-git'

" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" If fugitive.vim is the Git, rhubarb.vim is the Hub.
Plug 'tpope/vim-rhubarb'

" Git commit browser
" Plug 'junegunn/gv.vim'

" A Vim plugin for more pleasant editing on commit messages
Plug 'rhysd/committia.vim'

"----------------
" HTML
"----------------
" emmet for vim
Plug 'mattn/emmet-vim', { 'for': ['html', 'html.*'] }

"----------------
" Handlebars
"----------------
" Syntax, matchit support, navigations, text objects
Plug 'mustache/vim-mustache-handlebars',  { 'for': ['mustache', 'html.handlebars'] }

"----------------
" haproxy
"----------------
" Plug 'sclo/haproxy.vim'
Plug 'vim-scripts/haproxy', { 'for': 'haproxy' }

"----------------
" JS
"----------------
" Vastly improved Javascript indentation and syntax support
Plug 'pangloss/vim-javascript',      { 'for': 'javascript' }

" Enhanced javascript syntax file
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }

"----------------
" JSON
"----------------
" A better JSON for Vim: distinct highlighting of keywords as values,
" JSON-specific (non-JS) warnings, quote concealing.
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'GutenYe/json5.vim'

"----------------
" Markdown
"----------------
" Syntax highlighting, matching rules and mappings
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

"----------------
" Ruby
"----------------
" Ruby on Rails power tools
Plug 'tpope/vim-rails',   { 'for': ['ruby', 'eruby'] }

" Its' like rails.vim without the rails
Plug 'tpope/vim-rake',    { 'for': ['ruby', 'eruby'] }

" Configuration files for editing and compiling Ruby
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby'] }

" Better rspec syntax highlighting for Vim
Plug 'sheerun/rspec.vim', { 'for': 'ruby' }

" Ruby syntax extensions for highlighting YARD documentation
Plug 'sheerun/vim-yardoc', { 'for': 'ruby' }

" Lightweight support for Ruby's Bundler
Plug 'tpope/vim-bundler', { 'for': ['ruby', 'eruby'] }

"----------------
" Rust
"----------------
Plug 'rust-lang/rust.vim',   { 'for': 'rust' }
" Plug 'mattn/webapi-vim'

" Vim syntax for TOML
Plug 'cespare/vim-toml', {'for': 'toml'}

" Rust Cargo command bindings
" Plug 'timonv/vim-cargo', { 'for': ['rust'] }

"----------------
" SQL
"----------------
" Better SQL Syntax highlighting with errors.
Plug 'vim-scripts/sql.vim', { 'for': 'sql' }
Plug 'exu/pgsql.vim',       { 'for': 'sql' }

"----------------
" tmux
"----------------
" Syntax, navigation, building
Plug 'tmux-plugins/vim-tmux'

" Restores `FocusGained` and `FocusLost` autocommand events work when using
" vim inside Tmux.
Plug 'tmux-plugins/vim-tmux-focus-events'

"----------------
" TypeScript
"----------------
Plug 'HerringtonDarkholme/yats.vim'

"----------------
" YAML
"----------------
" Plug 'avakhov/vim-yaml',                  { 'for': 'yaml' }
" Plug 'ingydotnet/yaml-vim',               { 'for': 'yaml' }
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'tarekbecker/vim-yaml-formatter', { 'for': 'yaml' }

""===========================================================================""
" 25. various
""===========================================================================""
" A light and configurable statusline/tabline
" Plug 'itchyny/lightline.vim'
"
" Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" I like, but it doesn't show the whole path to the current file and that's
" not configurable.
Plug 'glepnir/spaceline.vim'

" Simple tmux statusline generator with support for powerline symbols and
" statusline / airline / lightline integration
" Plug 'edkolev/tmuxline.vim'
" Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Plug 'rbong/vim-crystalline'

" Plug '/Users/steve.loveless/Development/projects/pantsline.vim'
" Plug 'turboladen/pantsline.vim', { 'branch': 'feature/initial-stuff' }

""----------------------------------------------------------------------------
" Tools
""----------------------------------------------------------------------------
" Library of common functions
" Plug 'vim-scripts/ingo-library'

" Asynchronous Lint Engine
Plug 'dense-analysis/ale'

""----------------------------------------------------------------------------
" PLUGIN END
""----------------------------------------------------------------------------
call plug#end()

" Reload after saving this so I can PluginInstall.
augroup plugins_reloader
  autocmd!
augroup END

au plugins_reloader BufWritePost ~/.config/nvim/plugins.vim so $MYVIMRC
