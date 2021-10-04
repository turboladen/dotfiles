-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local function getHomebrewPathFor(package)
    local Job = require("plenary.job")

    local homebrew_root = ""
    local job =
        Job:new(
        {
            command = "brew",
            args = {"--prefix", package},
            on_stdout = function(_, data)
                homebrew_root = data
            end
        }
    )
    job:sync()

    return homebrew_root
end

-- local rust_tools_config = function()
--     vim.env.PATH = vim.env.PATH .. ":/usr/local/opt/llvm/bin"

--     local opts = {
--         tools = {
--             -- rust-tools options
--             inlay_hints = {
--                 show_parameter_hints = false
--             }
--         },
--         -- all the opts to send to nvim-lspconfig
--         -- these override the defaults set by rust-tools.nvim
--         -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
--         server = {
--             settings = rust_analyzer_settings
--         }
--     }
--     print("rust-tools setting up")
--     require("rust-tools").setup(opts)

--     vim.api.nvim_set_keymap("n", "K", ":RustHoverActions<CR>", {silent = true, noremap = true})
-- end

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
                            "rust",
                            "toml",
                            "typescript",
                            "yaml"
                        },
                        highlight = {enable = true},
                        matchup = {
                            enable = true
                        }
                    }
                end
            }

            -- Enhanced terminal integration for Vim.
            use "wincent/terminus"

            -- vim-signature is a plugin to place, toggle and display marks.
            use "kshenoy/vim-signature"

            -- Distraction-free writing in Vim.
            use {"junegunn/goyo.vim", config = "vim.g.goyo_width = 101", cmd = "Goyo"}

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

            -----------------------------------------------------------------------------
            -- 2. moving around, searching and patterns
            -----------------------------------------------------------------------------
            -- use { 'lotabout/skim', run = 'cd ~/.local/share/skim && ./install' }
            -- use {
            --     'lotabout/skim.vim',
            --     rtp = '/usr/local/opt/sk',
            --     requires = {'lotabout/skim'},
            --     config = function()
            --         vim.env.SKIM_DEFAULT_COMMAND = 'rg --files --color=always'
            --         vim.env.SKIM_DEFAULT_OPTIONS = '--layout=reverse --ansi'
            --         vim.api.nvim_set_keymap('n', '<leader>,', ':Rg <C-R><C-W><CR>', {})
            --         vim.api.nvim_set_keymap('n', '<leader>o', ':Rg TODO<CR>', {})
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

            -- use "airblade/vim-gitgutter"

            -- extended % matching for HTML, LaTeX and many other languages
            -- use "tmhedberg/matchit"

            -- Conquer of Completion
            use {
                "neoclide/coc.nvim",
                branch = "release",
                config = function()
                    -- local node_root = getHomebrewPathFor("node")
                    -- vim.g.coc_node_path = node_root .. "/bin/node"

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
                    -- vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "gD", "<Plug>(coc-declaration)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "[G", "<Plug>(coc-diagnostic-prev-error)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "]G", "<Plug>(coc-diagnostic-next-error)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "g=", "<Plug>(coc-format)", {silent = true})

                    -- vim.api.nvim_set_keymap("n", "rn", "<Plug>(coc-rename)", {silent = true})
                    -- vim.api.nvim_set_keymap("n", "gA", "<Plug>(coc-codeaction-line)", {})
                    -- vim.api.nvim_set_keymap("v", "gA", "<Plug>(coc-codeaction-selected)", {})
                    -- vim.api.nvim_set_keymap("n", "gB", "<Plug>(coc-codeaction-cursor)", {})
                    -- vim.api.nvim_set_keymap("v", "gB", "<Plug>(coc-codeaction)", {})
                    -- vim.api.nvim_set_keymap("n", "gF", "<Plug>(coc-fix-current)", {})
                    -- vim.api.nvim_set_keymap("n", "gR", "<Plug>(coc-refactor)", {})

                    -- Show all diagnostics.
                    -- vim.api.nvim_set_keymap(
                    --     "n",
                    --     "<leader>a",
                    --     ":<C-u>CocList diagnostics<CR>",
                    --     {silent = true, nowait = true, noremap = true}
                    -- )
                    -- Show all commands.
                    -- vim.api.nvim_set_keymap(
                    --     "n",
                    --     "<leader>cc",
                    --     ":<C-u>CocList commands<CR>",
                    --     {silent = true, nowait = true, noremap = true}
                    -- )
                    -- Search workspace symbols.
                    -- vim.api.nvim_set_keymap(
                    --     "n",
                    --     "<leader>cs",
                    --     ":<C-u>CocList -I symbols<CR>",
                    --     {silent = true, nowait = true, noremap = true}
                    -- )
                    -- Do default action for next item.
                    -- vim.api.nvim_set_keymap(
                    --     "n",
                    --     "<leader>j",
                    --     ":<C-u>CocNext<CR>",
                    --     {silent = true, nowait = true, noremap = true}
                    -- )
                    -- Do default action for previous item.
                    -- vim.api.nvim_set_keymap(
                    --     "n",
                    --     "<leader>k",
                    --     ":<C-u>CocPrev<CR>",
                    --     {silent = true, nowait = true, noremap = true}
                    -- )
                    -- Resume latest coc list.
                    -- vim.api.nvim_set_keymap(
                    --     "n",
                    --     "<leader>p",
                    --     ":<C-u>CocListResume<CR>",
                    --     {silent = true, nowait = true, noremap = true}
                    -- )

                    -- vim.api.nvim_set_keymap("n", "<leader>/", ":CocSearch<SPACE>", {noremap = true})

                    -- Use K for show documentation in preview window
                    -- vim.api.nvim_set_keymap('n', 'K', '<SID>show_documentation()<CR>', {silent = true, noremap = true})
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

            --===========================================================================
            -- 5. syntax, highlighting and spelling
            --===========================================================================
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

            --===========================================================================
            -- 6. multiple windows
            --===========================================================================
            -- Delete all the buffers except the current/named buffer
            use {
                "vim-scripts/BufOnly.vim",
                config = function()
                    vim.api.nvim_set_keymap("n", "<leader>q", ":BufOnly<CR>", {})
                end
            }

            --===========================================================================
            -- 13. editing text
            --===========================================================================
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

            --===========================================================================
            -- 21. executing external commands
            --===========================================================================
            -- Asynchronous build and test dispatcher. Used for running specs in a separate
            -- tmux pane.
            use {"tpope/vim-dispatch", opt = true, cmd = {"Dispatch", "Make", "Focus", "Start"}}

            -- Vim sugar for the UNIX shell commands that need it the most
            use {"tpope/vim-eunuch", opt = true, cmd = {"Delete", "Move", "Rename"}}

            -- run your tests at the speed of thought
            use {
                "vim-test/vim-test",
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

            use {
                "rcarriga/vim-ultest",
                requires = "vim-test/vim-test",
                run = ":UpdateRemotePlugins",
                config = function()
                    vim.g.ultest_use_pty = true

                    require("ultest").setup(
                        {
                            builders = {
                                ["ruby#rspec"] = function(cmd)
                                    for key, value in pairs(cmd) do
                                        print(key, " -- ", value)
                                    end
                                    local module = cmd[1]
                                    local args = cmd[2]
                                    -- local args = vim.list_slice(cmd, 3)

                                    return {
                                        dap = {
                                            type = "ruby",
                                            request = "launch",
                                            module = args
                                            -- module = module,
                                            -- args = args
                                        }
                                    }
                                end
                            }
                        }
                    )

                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>t :Ultest<CR>]])
                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>n :UltestNearest<CR>]])
                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>l :UltestLast<CR>]])
                    vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>s :TestSuite<CR>]])
                end
            }

            --===========================================================================
            -- 22. running make and jumping to errors (quickfix)
            --===========================================================================

            --===========================================================================
            -- 23. language specific
            --===========================================================================
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

            -- use '~/Development/projects/vim-rbs'
            use {"turboladen/vim-rbs", ft = {"ruby", "rbs", "ruby.rbs"}}

            ------------------
            -- Rust
            ------------------
            use {"rust-lang/rust.vim", ft = "rust"}

            -- Vim syntax for TOML
            use {"cespare/vim-toml", ft = "toml"}

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
                -- rocks = {'luacheck'},
                -- run = function()
                --         require('turboladen/installers').npm_install('write-good')
                --         require('turboladen/installers').npm_install('lua-fmt')
                -- end,
                cmd = "ALEEnable",
                config = function()
                    vim.g.ale_fix_on_save = true
                    vim.g.ale_sign_error = "✘"
                    vim.g.ale_sign_warning = "⚠"
                    vim.g.ale_disable_lsp = true

                    --  Only run linters named in ale_linters settings.
                    vim.g.ale_linters_explicit = true

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
                        ["*"] = {"remove_trailing_lines", "trim_whitespace"}
                    }

                    vim.api.nvim_set_keymap("n", "<leader>]", "<Plug>(ale_next_wrap)", {silent = true})
                    vim.api.nvim_set_keymap("n", "<leader>[", "<Plug>(ale_previous_wrap)", {silent = true})
                    vim.cmd [[ALEEnable]]
                end
            }

            use {
                "mfussenegger/nvim-dap",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                    local dap = require("dap")

                    -- dap.adapters.ruby = {
                    --     type = "executable",
                    --     command = "bundle",
                    --     args = {"exec", "readapt", "stdio"}
                    -- }
                    dap.adapters.ruby = {
                        type = "executable",
                        command = "readapt",
                        args = {"stdio"}
                    }

                    dap.configurations.rust = {
                        {
                            name = "Launch",
                            type = "lldb",
                            request = "launch",
                            program = function()
                                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                            end,
                            cwd = "${workspaceFolder}",
                            stopOnEntry = false,
                            args = {},
                            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                            --
                            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                            --
                            -- Otherwise you might get the following error:
                            --
                            --    Error on launch: Failed to attach to the target process
                            --
                            -- But you should be aware of the implications:
                            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                            runInTerminal = false
                        }
                    }

                    dap.configurations.ruby = {
                        {
                            type = "ruby",
                            request = "launch",
                            name = "Ruby",
                            program = "bundle",
                            programArgs = {"exec", "rspec"},
                            useBundler = true
                        }
                    }

                    vim.api.nvim_set_keymap(
                        "n",
                        "<C-S-5>",
                        ":lua require('dap').continue()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<C-S-0>",
                        ":lua require('dap').step_over()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<C-S-->",
                        ":lua require('dap').step_out()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>b",
                        ":lua require('dap').toggle_breakpoint()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>B",
                        ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>lp",
                        ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dr",
                        ":lua require('dap').repl.open()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dl",
                        ":lua require('dap').run_last()<CR>",
                        {silent = true, noremap = true}
                    )
                end
            }

            -- use {
            --     "neovim/nvim-lspconfig",
            --     config = function()
            --         -- Use a loop to conveniently call 'setup' on multiple servers and
            --         -- map buffer local keybindings when the language server attaches
            --         local nvim_lsp = require("lspconfig")

            --         for _, lsp in pairs(lsp_server_names) do
            --             print("lspconfig. Setting up sever... " .. lsp)
            --             nvim_lsp[lsp].setup {
            --                 on_attach = common_on_attach,
            --                 flags = {
            --                     debounce_text_changes = 150
            --                 }
            --             }
            --         end
            --     end
            -- }

            use {
                "williamboman/nvim-lsp-installer",
                requires = {
                    "neovim/nvim-lspconfig",
                    "simrat39/rust-tools.nvim"
                },
                config = function()
                    local function for_each_lsp_server(cb)
                        local server_names = {"rust_analyzer", "sumneko_lua"}

                        for _, server_name in pairs(server_names) do
                            cb(server_name)
                        end
                    end

                    for_each_lsp_server(
                        function(server_name)
                            local lsp_installer_servers = require("nvim-lsp-installer.servers")
                            local ok, server = lsp_installer_servers.get_server(name)
                            if ok then
                                if not server:is_installed() then
                                    server:install()
                                end
                            end
                        end
                    )

                    local lsp_installer = require("nvim-lsp-installer")

                    lsp_installer.on_server_ready(
                        function(server)
                            local opts = {
                                on_attach = function(client, bufnr)
                                    local function buf_set_keymap(...)
                                        vim.api.nvim_buf_set_keymap(bufnr, ...)
                                    end
                                    local function buf_set_option(...)
                                        vim.api.nvim_buf_set_option(bufnr, ...)
                                    end

                                    -- Enable completion triggered by <c-x><c-o>
                                    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

                                    -- Mappings.
                                    local opts = {noremap = true, silent = true}

                                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                                    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                                    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                                    if server.name == "rust_analyzer" then
                                        buf_set_keymap("n", "K", "<cmd>RustHoverActions<CR>", opts)
                                    else
                                        buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                                    end
                                    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                                    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                                    buf_set_keymap(
                                        "n",
                                        "<space>wa",
                                        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
                                        opts
                                    )
                                    buf_set_keymap(
                                        "n",
                                        "<space>wr",
                                        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
                                        opts
                                    )
                                    buf_set_keymap(
                                        "n",
                                        "<space>wl",
                                        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                                        opts
                                    )
                                    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
                                    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
                                    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                                    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                                    buf_set_keymap(
                                        "n",
                                        "<space>e",
                                        "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
                                        opts
                                    )
                                    buf_set_keymap("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
                                    buf_set_keymap("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
                                    buf_set_keymap(
                                        "n",
                                        "<space>q",
                                        "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
                                        opts
                                    )
                                    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
                                end,
                                flags = {
                                    debounce_text_changes = 150
                                }
                            }

                            if server.name == "rust_analyzer" then
                                vim.env.PATH = vim.env.PATH .. ":/usr/local/opt/llvm/bin"

                                opts.settings = {
                                    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                                    ["rust-analyzer"] = {
                                        assist = {
                                            importGranularity = "module",
                                            importPrefix = "by_self"
                                        },
                                        cargo = {
                                            allFeatures = true,
                                            loadOutDirsFromCheck = true
                                        },
                                        checkOnSave = {
                                            -- enable clippy on save
                                            command = "clippy",
                                            allFeatures = true
                                        },
                                        lens = {
                                            methodReferences = true
                                        }
                                        -- lruCapacity = 4096,
                                    }
                                }

                                local rust_opts = {
                                    tools = {
                                        -- rust-tools options
                                        inlay_hints = {
                                            show_parameter_hints = false
                                        }
                                    },
                                    -- all the opts to send to nvim-lspconfig
                                    -- these override the defaults set by rust-tools.nvim
                                    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
                                    server = opts
                                }

                                require("rust-tools").setup(rust_opts)
                            else
                                server:setup(opts)
                            end

                            -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
                            vim.cmd [[ do User LspAttachBuffers ]]
                        end
                    )
                end
            }

            use {
                "simrat39/rust-tools.nvim",
                requires = {
                    "neovim/nvim-lspconfig",
                    "nvim-lua/popup.nvim",
                    "nvim-lua/plenary.nvim",
                    "nvim-telescope/telescope.nvim",
                    "mfussenegger/nvim-dap"
                }
            }

            use {
                "rcarriga/nvim-dap-ui",
                requires = "mfussenegger/nvim-dap"
            }

            -- Simple plugins can be specified as strings
            -- use '9mm/vim-closer'

            -- Lazy loading:
            -- Load on specific commands

            -- Load on an autocommand event
            use {"andymass/vim-matchup", event = "VimEnter"}

            -- Plugins can have dependencies on other plugins
            -- use {
            --   'haorenW1025/completion-nvim',
            --   opt = true,
            --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
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
            use {
                "lewis6991/gitsigns.nvim",
                requires = {"nvim-lua/plenary.nvim"},
                config = function()
                    require("gitsigns").setup()
                end
            }

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
