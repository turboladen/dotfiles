-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

function getHomebrewPath()
    local Job = require("plenary.job")

    local homebrew_root = ""
    local job =
        Job:new(
        {
            command = "brew",
            args = {"--prefix"},
            on_stdout = function(_, data)
                homebrew_root = data
            end
        }
    )
    job:sync()

    return homebrew_root
end

return require("packer").startup(
    {
        function(use)
            -- Packer can manage itself
            use "wbthomason/packer.nvim"

            -----------------------------------------------------------------------------
            -- 0.
            -----------------------------------------------------------------------------
            -- Enable repeating supported plugin maps with '.'
            use "tpope/vim-repeat"

            ------------------------------------------------------------------------------
            -- UI tweaks
            ------------------------------------------------------------------------------
            -- Treesitter configurations and abstraction layer for Neovim.
            use {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                config = function()
                    require "nvim-treesitter.configs".setup {
                        ensure_installed = {
                            "bash",
                            "c",
                            "cmake",
                            "comment",
                            "cpp",
                            "dockerfile",
                            "html",
                            "javascript",
                            "json",
                            "lua",
                            "ruby",
                            "toml",
                            "typescript",
                            "yaml"
                        },
                        highlight = {enable = true}
                    }
                end
            }

            -- Enhanced terminal integration for Vim.
            use "wincent/terminus"

            -- vim-signature is a plugin to place, toggle and display marks.
            use "kshenoy/vim-signature"

            -- Distraction-free writing in Vim.
            use {"junegunn/goyo.vim", config = "vim.g.goyo_width = 101", cmd = "Goyo"}

            -- I like, but it doesn't show the whole path to the current file and that's
            -- not configurable.
            -- use {"glepnir/spaceline.vim", requires = "kyazdani42/nvim-web-devicons"}

            use {
                "datwaft/bubbly.nvim",
                config = function()
                    -- Here you can add the configuration for the plugin
                    vim.g.bubbly_palette = {
                        background = "#34343c",
                        foreground = "#c5cdd9",
                        black = "#3e4249",
                        red = "#ec7279",
                        green = "#a0c980",
                        yellow = "#deb974",
                        blue = "#6cb6eb",
                        purple = "#d38aea",
                        cyan = "#5dbbc1",
                        white = "#c5cdd9",
                        lightgrey = "#57595e",
                        darkgrey = "#404247"
                    }
                    vim.g.bubbly_statusline = {
                        "mode",
                        "truncate",
                        "path",
                        "branch",
                        "coc",
                        "divisor",
                        "filetype",
                        "progress"
                    }
                end
            }

            -- Plug '/Users/steve.loveless/Development/projects/pantsline.vim'
            -- Plug 'turboladen/pantsline.vim', { 'branch': 'feature/initial-stuff' }

            -----------------------------------------------------------------------------
            -- 2. moving around, searching and patterns
            -----------------------------------------------------------------------------
            -- use { 'lotabout/skim', run = "cd ~/.local/share/skim && ./install" }
            -- use {
            --     "lotabout/skim.vim",
            --     rtp = "/usr/local/opt/sk",
            --     requires = {"lotabout/skim"},
            --     config = function()
            --         vim.env.SKIM_DEFAULT_COMMAND = "rg --files --color=always"
            --         vim.env.SKIM_DEFAULT_OPTIONS = "--layout=reverse --ansi"
            --         vim.api.nvim_set_keymap("n", "<leader>,", ":Rg <C-R><C-W><CR>", {})
            --         vim.api.nvim_set_keymap("n", "<leader>o", ":Rg TODO<CR>", {})
            --     end
            -- }
            use {
                "liuchengxu/vim-clap",
                run = ":Clap install-binary",
                requires = {
                    "kyazdani42/nvim-web-devicons"
                },
                config = function()
                    vim.g.clap_disable_run_rooter = true
                    vim.g.clap_layout = {relative = "editor"}
                    vim.g.clap_enable_icon = true

                    vim.api.nvim_set_keymap("n", "<leader><leader>", ":Clap files<CR>", {noremap = true, silent = true})
                    vim.api.nvim_set_keymap("n", "<leader><CR>", ":Clap buffers<CR>", {noremap = true, silent = true})
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>,",
                        ":Clap grep2 <C-R><C-W><CR>",
                        {noremap = true, silent = true}
                    )
                    vim.api.nvim_set_keymap("n", "<leader>o", ":Clap grep TODO<CR>", {noremap = true, silent = true})
                end
            }

            use {
                "ibhagwan/fzf-lua",
                requires = {
                    "vijaymarupudi/nvim-fzf",
                    "kyazdani42/nvim-web-devicons"
                },
                disable = true,
                config = function()
                    require("fzf-lua").setup(
                        {
                            fzf_bin = "sk",
                            files = {
                                cmd = "rg --files --vimgrep --color=always"
                            }
                        }
                    )

                    vim.env.SKIM_DEFAULT_COMMAND = "rg --files --color=always"
                    vim.env.SKIM_DEFAULT_OPTIONS = "--layout=reverse --ansi"
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader><leader>",
                        ":FzfLua files<CR>",
                        {noremap = true, silent = true}
                    )
                    vim.api.nvim_set_keymap("n", "<leader><CR>", ":FzfLua buffers<CR>", {noremap = true, silent = true})
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>,",
                        ":FzfLua grep <C-R><C-W><CR>",
                        {noremap = true, silent = true}
                    )
                    vim.api.nvim_set_keymap("n", "<leader>o", ":FzfLua grep TODO<CR>", {noremap = true, silent = true})
                end
            }

            -- Use RipGrep in Vim and display results in a quickfix list
            use {
                "jremmen/vim-ripgrep",
                cmd = "Rg",
                config = function()
                    vim.g.rg_command = "rg --vimgrep --ignore-vcs"
                    vim.g.rg_highlight = 1
                end
            }

            -- combine with netrw to create a delicious salad dressing.
            use "tpope/vim-vinegar"

            -- pairs of handy bracket mappings
            use "tpope/vim-unimpaired"

            -- Directory viewer for Vim
            use "justinmk/vim-dirvish"
            use {"kristijanhusak/vim-dirvish-git", requires = {"justinmk/vim-dirvish"}}

            use "airblade/vim-gitgutter"

            -- extended % matching for HTML, LaTeX and many other languages
            use "tmhedberg/matchit"

            -- Conquer of Completion
            use {
                "neoclide/coc.nvim",
                branch = "release",
                config = function()
                    vim.g.coc_node_path = getHomebrewPath() .. "/bin/node"

                    -- coc-dictionary: Words from files in &dictionary.
                    -- coc-git: Somewhat replaces gitgutter; kinda depends on vim-fugitive.
                    -- coc-html: HTML language server.
                    -- coc-lists: Some basic list sources
                    -- coc-prettier: Code reformatting--initially got for markdown
                    vim.g.coc_global_extensions = {
                        "coc-dictionary",
                        "coc-git",
                        "coc-html",
                        "coc-lists",
                        "coc-markdownlint",
                        "coc-prettier",
                        "coc-rust-analyzer",
                        "coc-solargraph",
                        "coc-snippets",
                        "coc-toml",
                        "coc-yaml"
                    }
                    -- Use <C-j> for jump to next placeholder, it's default of coc.nvim
                    vim.g.coc_snippet_next = "<c-j>"

                    -- Use <C-k> for jump to previous placeholder, it's default of coc.nvim
                    vim.g.coc_snippet_prev = "<c-k>"

                    -- https://kimpers.com/vim-intelligent-autocompletion/
                    -- Remap keys for gotos
                    vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
                    vim.api.nvim_set_keymap("n", "gD", "<Plug>(coc-declaration)", {silent = true})
                    vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
                    vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
                    vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", {silent = true})
                    vim.api.nvim_set_keymap("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
                    vim.api.nvim_set_keymap("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
                    vim.api.nvim_set_keymap("n", "[G", "<Plug>(coc-diagnostic-prev-error)", {silent = true})
                    vim.api.nvim_set_keymap("n", "]G", "<Plug>(coc-diagnostic-next-error)", {silent = true})
                    vim.api.nvim_set_keymap("n", "g=", "<Plug>(coc-format)", {silent = true})

                    vim.api.nvim_set_keymap("n", "rn", "<Plug>(coc-rename)", {silent = true})
                    vim.api.nvim_set_keymap("n", "gA", "<Plug>(coc-codeaction-line)", {})
                    vim.api.nvim_set_keymap("v", "gA", "<Plug>(coc-codeaction-selected)", {})
                    vim.api.nvim_set_keymap("n", "gB", "<Plug>(coc-codeaction-cursor)", {})
                    vim.api.nvim_set_keymap("v", "gB", "<Plug>(coc-codeaction)", {})
                    vim.api.nvim_set_keymap("n", "gF", "<Plug>(coc-fix-current)", {})
                    vim.api.nvim_set_keymap("n", "gR", "<Plug>(coc-refactor)", {})

                    -- Show all diagnostics.
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>a",
                        ":<C-u>CocList diagnostics<CR>",
                        {silent = true, nowait = true, noremap = true}
                    )
                    -- Show all commands.
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>cc",
                        ":<C-u>CocList commands<CR>",
                        {silent = true, nowait = true, noremap = true}
                    )
                    -- Search workspace symbols.
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>cs",
                        ":<C-u>CocList -I symbols<CR>",
                        {silent = true, nowait = true, noremap = true}
                    )
                    -- Do default action for next item.
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>j",
                        ":<C-u>CocNext<CR>",
                        {silent = true, nowait = true, noremap = true}
                    )
                    -- Do default action for previous item.
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>k",
                        ":<C-u>CocPrev<CR>",
                        {silent = true, nowait = true, noremap = true}
                    )
                    -- Resume latest coc list.
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>p",
                        ":<C-u>CocListResume<CR>",
                        {silent = true, nowait = true, noremap = true}
                    )

                    vim.api.nvim_set_keymap("n", "<leader>/", ":CocSearch<SPACE>", {noremap = true})

                    -- Use K for show documentation in preview window
                    -- vim.api.nvim_set_keymap("n", "K", "<SID>show_documentation()<CR>", {silent = true, noremap = true})
                end
            }

            -- Change code right in the quickfix window
            use "stefandtw/quickfix-reflector.vim"

            -- Vim motion on speed!
            use {
                "phaazon/hop.nvim",
                opt = true,
                config = function()
                    require("hop").setup()
                    vim.api.nvim_set_keymap("n", "<leader>h", ":lua require('hop').hint_char1()<CR>", {})
                end
            }

            --===========================================================================""
            -- 5. syntax, highlighting and spelling
            --===========================================================================""
            ----------------------------------------
            -- Color schemes
            ----------------------------------------
            use "aonemd/kuroi.vim"
            use {"humanoid-colors/vim-humanoid-colorscheme", disable = true}
            use {"trusktr/seti.vim", disable = true}
            use {"rakr/vim-one", disable = true}
            use {"jaredgorski/SpaceCamp", disable = true}
            use {"jsit/toast.vim", disable = true}

            -- Hyperfocus-writing in Vim
            use {
                "junegunn/limelight.vim",
                config = "vim.g.limelight_paragraph_span = 1",
                cmd = "Limelight"
            }

            -- Show vertical line for indentation level
            use {"Yggdroot/indentLine", ft = "yaml"}

            --===========================================================================""
            -- 6. multiple windows
            --===========================================================================""
            -- Delete all the buffers except the current/named buffer
            use {
                "vim-scripts/BufOnly.vim",
                config = function()
                    vim.api.nvim_set_keymap("n", "<leader>q", ":BufOnly<CR>", {})
                end
            }

            --===========================================================================""
            -- 13. editing text
            --===========================================================================""
            -- wisely add 'end' in ruby, endfucntion/endif/more in vimscript, etc.
            use "tpope/vim-endwise"

            -- Closes brackets. Perfect companion to vim-endwise. Basically, a more
            -- conservative version of auto-pairs that only works when you press Enter.
            use {"rstacruz/vim-closer", requires = "tpope/vim-endwise"}

            -- comment stuff out
            use "tpope/vim-commentary"

            -- quoting/parenthesizing made simple
            use "tpope/vim-surround"

            -- Adds gS and gJ to split/join code blocks.
            use "AndrewRadev/splitjoin.vim"

            -- Easy text exchange operator
            use "tommcdo/vim-exchange"

            -- Protect against weird unicode copy/paste
            use "vim-utils/vim-troll-stopper"

            use "honza/vim-snippets"

            -- For case swapping
            use {
                "idanarye/vim-casetrate",
                config = function()
                    vim.g.casetrate_leader = "\\c"
                end
            }

            -- Vim script for text filtering and alignment
            use {"godlygeek/tabular", opt = true, cmd = "Tabularize"}

            --===========================================================================""
            -- 21. executing external commands
            --===========================================================================""
            -- Asynchronous build and test dispatcher. Used for running specs in a separate
            -- tmux pane.
            use {"tpope/vim-dispatch", opt = true, cmd = {"Dispatch", "Make", "Focus", "Start"}}

            -- Vim sugar for the UNIX shell commands that need it the most
            use {"tpope/vim-eunuch", opt = true, cmd = {"Delete", "Move", "Rename"}}

            -- run your tests at the speed of thought
            use {
                "janko-m/vim-test",
                opt = true,
                ft = "ruby",
                config = function()
                    vim.g["test#strategy"] = "dispatch"
                    vim.g["test#preserve_screen"] = 1
                    vim.g["test#enabled_runners"] = {"ruby#rspec"}

                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>t :TestFile<CR>]])
                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>n :TestNearest<CR>]])
                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>l :TestLast<CR>]])
                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>s :TestSuite<CR>]])
                end
            }

            --===========================================================================""
            -- 22. running make and jumping to errors (quickfix)
            --===========================================================================""

            --===========================================================================""
            -- 23. language specific
            --===========================================================================""
            ------------------
            -- CSS
            ------------------
            -- Cutting-edge vim css syntax file
            use {"JulesWang/css.vim", opt = true, ft = "css"}

            ------------------
            -- dockerfile
            ------------------
            use {"ekalinin/Dockerfile.vim", opt = true, ft = "dockerfile"}

            ------------------
            -- Elixir
            ------------------
            use {"elixir-lang/vim-elixir", opt = true, ft = {"elixir", "eelixir"}}
            use {"avdgaag/vim-phoenix", opt = true, ft = {"elixir", "eelixir"}}

            ------------------
            -- Elm
            ------------------
            use {"elmcast/elm-vim", opt = true, ft = "elm"}

            ------------------
            -- Git
            ------------------
            -- Vim Git syntax highlighting
            use {"tpope/vim-git", ft = {"git", "gitconfig", "gitcommit", "gitsendmail"}}

            -- a Git wrapper so awesome, it should be illegal
            use "tpope/vim-fugitive"

            -- If fugitive.vim is the Git, rhubarb.vim is the Hub.
            use "tpope/vim-rhubarb"

            -- A Vim plugin for more pleasant editing on commit messages
            use "rhysd/committia.vim"

            ------------------
            -- HTML
            ------------------
            -- emmet for vim
            use {"mattn/emmet-vim", opt = true, ft = {"html", "html.*"}}

            ------------------
            -- Handlebars
            ------------------
            -- Syntax, matchit support, navigations, text objects
            use {"mustache/vim-mustache-handlebars", opt = true, ft = {"mustache", "html.handlebars"}}

            ------------------
            -- haproxy
            ------------------
            use {"vim-scripts/haproxy", opt = true, ft = "haproxy"}

            ------------------
            -- JS
            ------------------
            -- Vastly improved Javascript indentation and syntax support
            use {"pangloss/vim-javascript", opt = true, ft = "javascript"}

            -- Enhanced javascript syntax file
            use {"jelera/vim-javascript-syntax", opt = true, ft = "javascript"}

            ------------------
            -- JSON
            ------------------
            -- A better JSON for Vim: distinct highlighting of keywords as values,
            -- JSON-specific (non-JS) warnings, quote concealing.
            use "elzr/vim-json"
            -- Plug 'GutenYe/json5.vim'

            ------------------
            -- Markdown
            ------------------
            -- Syntax highlighting, matching rules and mappings
            use {
                "plasticboy/vim-markdown",
                ft = "markdown",
                requires = "godlygeek/tabular",
                config = function()
                    vim.g.vim_markdown_folding_disabled = 1
                    vim.g.vim_markdown_conceal = 0
                    vim.g.vim_markdown_follow_anchor = 1
                    vim.g.vim_markdown_new_list_item_indent = 2
                    vim.g.vim_markdown_no_default_key_mappings = 1
                    vim.g.vim_markdown_strikethrough = 1
                end
            }

            ------------------
            -- Ruby
            ------------------
            -- Configuration files for editing and compiling Ruby
            use {
                "vim-ruby/vim-ruby",
                ft = {"ruby", "eruby"},
                config = function()
                    vim.g.ruby_operators = 1
                    vim.g.ruby_spellcheck_strings = 1
                    vim.g.ruby_space_errors = 1

                    vim.g.rubycomplete_buffer_loading = 1
                    vim.g.rubycomplete_classes_in_global = 1
                    vim.g.rubycomplete_load_gemfile = 1
                end
            }

            -- Ruby on Rails power tools
            use {"tpope/vim-rails", ft = {"ruby", "eruby"}}

            -- Its' like rails.vim without the rails
            use {
                "tpope/vim-rake",
                opt = true,
                ft = {"ruby", "eruby"},
                requires = "tpope/vim-projectionist"
            }

            -- Better rspec syntax highlighting for Vim
            use {"sheerun/rspec.vim", ft = "ruby"}

            -- Ruby syntax extensions for highlighting YARD documentation
            use {
                "sheerun/vim-yardoc",
                ft = "ruby",
                requires = "vim-ruby/vim-ruby",
                config = function()
                    vim.cmd("hi link yardGenericTag rubyInstanceVariable")
                    vim.cmd("hi link yardTypeList rubyConstant")
                    vim.cmd("hi link yardType rubyConstant")
                end
            }

            use "~/Development/projects/vim-rbs"

            -- Lightweight support for Ruby's Bundler
            use {"tpope/vim-bundler", ft = {"ruby", "eruby"}}

            ------------------
            -- Rust
            ------------------
            use {"rust-lang/rust.vim", ft = "rust"}

            -- Vim syntax for TOML
            use "cespare/vim-toml"

            ------------------
            -- SQL
            ------------------
            -- Better SQL Syntax highlighting with errors.
            use {"vim-scripts/sql.vim", opt = true, ft = "sql"}
            use {"exu/pgsql.vim", opt = true, ft = "sql"}

            ------------------
            -- tmux
            ------------------
            -- Syntax, navigation, building
            use "tmux-plugins/vim-tmux"

            -- Restores `FocusGained` and `FocusLost` autocommand events work when using
            -- vim inside Tmux.
            use "tmux-plugins/vim-tmux-focus-events"

            ------------------
            -- TypeScript
            ------------------
            use {"HerringtonDarkholme/yats.vim", opt = true, ft = {"typescript", "typescriptreact"}}

            ------------------
            -- YAML
            ------------------
            use {"stephpy/vim-yaml", ft = "yaml"}
            use {"tarekbecker/vim-yaml-formatter", ft = "yaml", disable = true}

            --===========================================================================
            -- 25. various
            --===========================================================================
            use "nvim-lua/plenary.nvim"

            use {
                "dense-analysis/ale",
                requires = "nvim-lua/plenary.nvim",
                -- rocks = {"luacheck"},
                run = function()
                        require("turboladen/installers").npm_install("write-good")
                        require("turboladen/installers").npm_install("lua-fmt")
                end,
                config = function()
                    vim.g.ale_fix_on_save = 1
                    vim.g.ale_sign_error = "✘"
                    vim.g.ale_sign_warning = "⚠"
                    vim.g.ale_disable_lsp = 1

                    --  Only run linters named in ale_linters settings.
                    vim.g.ale_linters_explicit = 1

                    vim.g.ale_linters = {
                        lua = {"luacheck"},
                        markdown = {"proselint", "writegood"},
                        ruby = {"brakeman", "debride", "reek", "rubocop", "ruby", "sorbet"},
                        vim = {"vint"},
                        zsh = {"shellcheck"}
                    }

                    vim.g.ale_fixers = {
                        ["lua"] = {"luafmt"},
                        ["ruby"] = {"rubocop"},
                        ["rust"] = {"rustfmt"},
                        ["*"] = {"remove_trailing_lines", "trim_whitespace"}
                    }
                    -- vim.g.ale_fixers["*"] = {"remove_trailing_lines", "trim_whitespace"}

                    vim.api.nvim_set_keymap("n", "<leader>]", "<Plug>(ale_next_wrap)", {silent = true})
                    vim.api.nvim_set_keymap("n", "<leader>[", "<Plug>(ale_previous_wrap)", {silent = true})
                end
            }

            -- Simple plugins can be specified as strings
            -- use '9mm/vim-closer'

            -- Lazy loading:
            -- Load on specific commands

            -- Load on an autocommand event
            -- use {'andymass/vim-matchup', event = 'VimEnter'}

            -- Plugins can have dependencies on other plugins
            -- use {
            --   'haorenW1025/completion-nvim',
            --   opt = true,
            --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
            -- }

            -- Plugins can also depend on rocks from luarocks.org:
            -- use {
            --   'my/supercoolplugin',
            --   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
            -- }

            -- You can specify rocks in isolation
            -- use_rocks 'penlight'
            -- use_rocks {'lua-resty-http', 'lpeg'}

            -- Local plugins can be included
            -- use '~/projects/personal/hover.nvim'

            -- Plugins can have post-install/update hooks
            -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

            -- Post-install/update hook with neovim command
            -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

            -- Post-install/update hook with call of vimscript function with argument
            -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

            -- Use specific branch, dependency and run lua file after load
            -- use {
            --   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
            --   requires = {'kyazdani42/nvim-web-devicons'}
            -- }

            -- Use dependency and run lua function after load
            -- use {
            --   'lewis6991/gitsigns.nvim',
            --   requires = { 'nvim-lua/plenary.nvim' },
            --   config = function() require('gitsigns').setup() end
            -- }

            -- You can specify multiple plugins in a single call
            -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

            -- You can alias plugin names
            -- use {'dracula/vim', as = 'dracula'}

            -- use {
            --   'lewis6991/spellsitter.nvim',
            --   config = function()
            --     require('spellsitter').setup()
            --   end
            -- }

            -- use {
            --   'beauwilliams/statusline.lua',
            --   requires = { 'nvim-lua/lsp-status.nvim' },
            --   config = function()
            --     local statusline = require('statusline')
            --   end
            -- }
        end,
        config = {
            display = {
                open_fn = require("packer.util").float
            }
        }
    }
)
