-- This file can be loaded by calling `lua require('plugins')` from your init.vim

function ShowDocumentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({"vim", "help"}, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({"man"}, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    elseif vim.fn.expand("%:t") == "Cargo.toml" then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
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

            -- https://github.com/datwaft/bubbly.nvim
            use {
                "datwaft/bubbly.nvim",
                requires = "nvim-lua/lsp-status.nvim",
                config = function()
                    require("lsp-status").register_progress()

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
                        "lsp_status.messages",
                        "lsp_status.diagnostics",
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

            -- https://github.com/liuchengxu/vim-clap
            -- Vim-clap is a modern generic interactive finder and dispatcher
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
                    vim.g.clap_provider_dotfiles = {
                        source = {
                            "~/.Brewfile",
                            "~/.Brewfile##template",
                            "~/.cargo/config.toml",
                            "~/.config/alacritty/alacritty.yml",
                            "~/.config/nvim/init.vim",
                            "~/.config/nvim/lua/plugins.lua",
                            "~/.config/yadm/bootstrap",
                            "~/.gemrc",
                            "~/.gitconfig",
                            "~/.gitconfig##template",
                            "~/.gitconfig-personal",
                            "~/.gitconfig-work",
                            "~/.gitconfig-work##class.Work",
                            "~/.gitignore_global",
                            "~/.irbrc",
                            "~/.profile",
                            "~/.rustup/settings.toml",
                            "~/.ssh/config",
                            "~/.tmux.conf",
                            "~/.tmux.conf##template",
                            "~/.zshrc",
                            "~/.zshenv"
                        },
                        sink = "e",
                        description = "Open a dotfile"
                    }

                    vim.cmd(
                        [[autocmd FileType clap_input lua require('cmp').setup.buffer { enabled = false }
                    ]]
                    )

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

                    vim.api.nvim_set_keymap("n", "<leader>.", ":Rg<SPACE><CR>", {noremap = true})
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
                disable = true,
                config = function()
                    -- coc-dictionary: Words from files in &dictionary.
                    -- coc-git: Somewhat replaces gitgutter; kinda depends on vim-fugitive.
                    -- coc-html: HTML language server.
                    -- coc-lists: Some basic list sources
                    -- coc-prettier: Code reformatting--initially got for markdown
                    vim.g.coc_global_extensions = {
                        "coc-html",
                        "coc-lists",
                        "coc-markdownlint",
                        "coc-prettier",
                        "coc-toml"
                    }
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

            -- use "honza/vim-snippets"

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
            use {"tpope/vim-eunuch", opt = true, cmd = {"Delete", "Move", "Rename", "Remove"}}

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
            use {
                "tpope/vim-fugitive",
                config = function()
                    vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<CR>", {silent = true})
                end
            }

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
            use {
                "elzr/vim-json",
                config = function()
                    vim.g.vim_json_syntax_conceal = false
                end
            }
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
                "mhartington/formatter.nvim",
                config = function()
                    require("formatter").setup(
                        {
                            filetype = {
                                javascript = {
                                    -- prettier
                                    function()
                                        return {
                                            exe = "prettier",
                                            args = {
                                                "--stdin-filepath",
                                                vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                                                "--single-quote"
                                            },
                                            stdin = true
                                        }
                                    end
                                }
                            }
                        }
                    )
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

            use {
                "williamboman/nvim-lsp-installer",
                requires = {
                    "neovim/nvim-lspconfig",
                    "simrat39/rust-tools.nvim",
                    "nvim-lua/lsp-status.nvim"
                },
                config = function()
                    local function for_each_lsp_server(cb)
                        local server_names = {"rust_analyzer", "sumneko_lua", "jsonls", "solargraph", "vimls", "yamlls"}

                        for _, server_name in pairs(server_names) do
                            cb(server_name)
                        end
                    end

                    for_each_lsp_server(
                        function(server_name)
                            local lsp_installer_servers = require("nvim-lsp-installer.servers")
                            local ok, server = lsp_installer_servers.get_server(server_name)
                            if ok then
                                if not server:is_installed() then
                                    server:install()
                                end
                            end
                        end
                    )

                    local lsp_installer = require("nvim-lsp-installer")
                    local lsp_status = require("lsp-status")
                    -- lsp_status.register_progress()

                    lsp_installer.on_server_ready(
                        function(server)
                            local opts = {
                                capabilities = lsp_status.capabilities,
                                on_attach = function(client, bufnr)
                                    -- Register client for messages and set up buffer autocommands to update
                                    -- the statusline and the current function.
                                    -- NOTE: on_attach is called with the client object, which is the "client" parameter below
                                    lsp_status.on_attach(client)

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
                                        completion = {
                                            autoimport = {
                                                enable = true
                                            }
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
                "hrsh7th/nvim-cmp",
                requires = {
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-nvim-lsp",
                    "neovim/nvim-lspconfig",
                    "hrsh7th/vim-vsnip",
                    "hrsh7th/cmp-vsnip",
                    "rafamadriz/friendly-snippets",
                    "f3fora/cmp-spell",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-nvim-lua",
                    -- https://github.com/octaltree/cmp-look
                    "octaltree/cmp-look",
                    -- https://github.com/onsails/lspkind-nvim
                    "onsails/lspkind-nvim"
                },
                config = function()
                    local cmp = require("cmp")
                    local lspkind = require("lspkind")

                    cmp.setup(
                        {
                            completion = {
                                keyword_length = 2
                            },
                            formatting = {
                                format = function(entry, vim_item)
                                    vim_item.kind = lspkind.presets.default[vim_item.kind]

                                    -- set a name for each source
                                    vim_item.menu =
                                        ({
                                        nvim_lsp = "[LSP]",
                                        vsnip = "[V-Snip]",
                                        buffer = "[Buffer]",
                                        path = "[Path]",
                                        spell = "[Spell]",
                                        look = "[Look]",
                                        nvim_lua = "[Lua]",
                                        crates = "[Crates]"
                                    })[entry.source.name]

                                    return vim_item
                                end
                            },
                            mapping = {
                                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                                ["<C-Space>"] = cmp.mapping.complete(),
                                ["<C-e>"] = cmp.mapping.close(),
                                ["<CR>"] = cmp.mapping.confirm({select = true})
                            },
                            snippet = {
                                expand = function(args)
                                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
                                end
                            },
                            sources = {
                                {name = "nvim_lsp"},
                                {name = "vsnip"},
                                {name = "buffer"},
                                {name = "path"},
                                {name = "spell"},
                                {name = "look", keyword_length = 2},
                                {name = "nvim_lua"},
                                {name = "crates"}
                            }
                        }
                    )

                    -- Setup lspconfig.
                    local servers = require("nvim-lsp-installer.servers").get_installed_servers()

                    for _, server in pairs(servers) do
                        require("lspconfig")[server.name].setup {
                            capabilities = require("cmp_nvim_lsp").update_capabilities(
                                vim.lsp.protocol.make_client_capabilities()
                            )
                        }
                    end

                    -- Expand
                    vim.api.nvim_set_keymap(
                        "i",
                        "<C-j>",
                        "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'",
                        {expr = true}
                    )
                    vim.api.nvim_set_keymap(
                        "s",
                        "<C-j>",
                        "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'",
                        {expr = true}
                    )

                    -- Expand or jump
                    vim.api.nvim_set_keymap(
                        "i",
                        "<C-l>",
                        "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'",
                        {expr = true}
                    )
                    vim.api.nvim_set_keymap(
                        "s",
                        "<C-l>",
                        "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'",
                        {expr = true}
                    )

                    -- Jump forward or backward
                    vim.api.nvim_set_keymap(
                        "i",
                        "<Tab>",
                        "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
                        {expr = true}
                    )
                    vim.api.nvim_set_keymap(
                        "s",
                        "<Tab>",
                        "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
                        {expr = true}
                    )
                    vim.api.nvim_set_keymap(
                        "i",
                        "<S-Tab>",
                        "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
                        {expr = true}
                    )
                    vim.api.nvim_set_keymap(
                        "s",
                        "<S-Tab>",
                        "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
                        {expr = true}
                    )
                end
            }

            use {
                "Saecki/crates.nvim",
                event = {"BufEnter Cargo.toml"},
                requires = {"nvim-lua/plenary.nvim"},
                config = function()
                    require("crates").setup()

                    vim.api.nvim_set_keymap("n", "K", ":lua ShowDocumentation()<CR>", {noremap = true, silent = true})
                end
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
                    require("gitsigns").setup(
                        {
                            signs = {
                                add = {text = "✚"},
                                change = {text = "✹"},
                                delete = {text = "✖"},
                                changedelete = {text = "⇄"}
                            },
                            yadm = {enable = true}
                        }
                    )
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
