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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'

""===========================================================================""
" 2. moving around, searching and patterns
""===========================================================================""
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'

" Use RipGrep in Vim and display results in a quickfix list
Plug 'jremmen/vim-ripgrep'

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

" Vim motion on speed!
Plug 'phaazon/hop.nvim'

""===========================================================================""
" 5. syntax, highlighting and spelling
""===========================================================================""
" Color schema
" Plug 'humanoid-colors/vim-humanoid-colorscheme'

" Color scheme
Plug 'aonemd/kuroi.vim'

" Color Scheme
" Plug 'trusktr/seti.vim'

" Adaptation of one-light and one-dark colorschemes for Vim
" Plug 'rakr/vim-one'

" 🔭 Vim colors for the final frontier.
" Plug 'jaredgorski/SpaceCamp'

" Hyperfocus-writing in Vim
Plug 'junegunn/limelight.vim'

" Show vertical line for indentation level
Plug 'Yggdroot/indentLine', { 'for': ['yaml'] }

" Toast! A colorful, medium-contrast theme with full Vim and Neovim support,
" true color and 256-color support, and automatic light and dark variants. Easy
" to read without frying your retinae.
" Plug 'jsit/toast.vim'

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
Plug 'AndrewRadev/splitjoin.vim', { 'for': ['ruby'] }

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

""===========================================================================""
" 21. executing external commands
""===========================================================================""
" Asynchronous build and test dispatcher. Used for running specs in a separate
" tmux pane.
Plug 'tpope/vim-dispatch'

" Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-eunuch'

" run your tests at the speed of thought
Plug 'janko-m/vim-test', { 'for': ['ruby'] }

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
" Plug 'GutenYe/json5.vim'

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
Plug 'kyazdani42/nvim-web-devicons'

" I like, but it doesn't show the whole path to the current file and that's
" not configurable.
Plug 'glepnir/spaceline.vim'

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
