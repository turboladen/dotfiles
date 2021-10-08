-- This file can be loaded by calling `lua require('plugins')` from your init.vim

function SteveUltest()
    vim.cmd([[UltestSummaryOpen]])
    vim.cmd([[Ultest]])
end

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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function _GeneralOnAttach(server_name, client, bufnr)
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
    if server_name == "rust_analyzer" then
        buf_set_keymap("n", "K", "<cmd>RustHoverActions<CR>", opts)
    else
        buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    end
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
    -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

function _MakeLspOpts(server_name, capabilities)
    return {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            _GeneralOnAttach(server_name, client, bufnr)
        end,
        flags = {
            debounce_text_changes = 150
        }
    }
end

return require("packer").startup(
    {
        function(use)
            -- https://github.com/wbthomason/packer.nvim
            use {
                "wbthomason/packer.nvim",
                config = function()
                    vim.cmd(
                        [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
                    )
                end
            }

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

            -- Change code right in the quickfix window
            use "stefandtw/quickfix-reflector.vim"

            --===========================================================================
            -- 5. syntax, highlighting and spelling
            --===========================================================================
            ----------------------------------------
            -- Color schemes
            ----------------------------------------
            use "aonemd/kuroi.vim"
            -- use "humanoid-colors/vim-humanoid-colorscheme"
            -- use "trusktr/seti.vim"
            -- use "rakr/vim-one"
            -- use "jaredgorski/SpaceCamp"
            -- use "jsit/toast.vim"
            use {
                "marko-cerovac/material.nvim",
                config = function()
                    vim.g.material_style = "darker"
                    -- vim.g.material_style = "deep ocean"
                    -- vim.g.material_style = "lighter"
                end
            }

            -- Hyperfocus-writing in Vim
            use {
                "junegunn/limelight.vim",
                config = "vim.g.limelight_paragraph_span = 1",
                cmd = "Limelight"
            }

            -- Show vertical line for indentation level
            use {
                "lukas-reineke/indent-blankline.nvim",
                config = function()
                    vim.opt.list = true

                    require("indent_blankline").setup(
                        {
                            buftype_exclude = {"terminal"},
                            space_char_blankline = " ",
                            show_current_context = true
                        }
                    )
                end
            }

            --===========================================================================
            -- 6. multiple windows
            --===========================================================================
            -- Delete all the buffers except the current/named buffer
            use {
                "vim-scripts/BufOnly.vim",
                cmd = "BufOnly"
            }

            --===========================================================================
            -- 13. editing text
            --===========================================================================
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

            -- For case swapping
            use {
                "idanarye/vim-casetrate",
                cmd = "Casetrate"
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
                requires = "tpope/vim-dispatch",
                ft = {"ruby", "rust"},
                config = function()
                    vim.g["test#strategy"] = "dispatch"
                    vim.g["test#preserve_screen"] = true
                    vim.g["test#enabled_runners"] = {
                        "ruby#rspec",
                        "ruby#rails",
                        "rust#cargotest"
                    }

                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tf <cmd>TestFile<CR>]])
                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tn <cmd>TestNearest<CR>]])
                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>ta <cmd>TestSuite<CR>]])
                end
            }

            use {
                "rcarriga/vim-ultest",
                requires = "vim-test/vim-test",
                run = ":UpdateRemotePlugins",
                ft = {"ruby", "rust"},
                config = function()
                    vim.g.ultest_use_pty = 1
                    vim.g.ultest_virtual_text = 1

                    -- https://www.nerdfonts.com/cheat-sheet
                    -- vim.g.ultest_running_sign = require("nvim-web-devicons").get_icon("test.diff", "diff")
                    -- local spinner = ""
                    -- local pomodoro_ticking = ""
                    -- local beaker = ""
                    local weather_refresh = ""
                    vim.g.ultest_running_sign = weather_refresh

                    vim.api.nvim_set_keymap("n", "]t", "<Plug>(ultest-next-fail)", {})
                    vim.api.nvim_set_keymap("n", "[t", "<Plug>(ultest-prev-fail)", {})
                    -- I wanna be able to turn off the sidebar thing even if I switched to a buffer that's not ruby or rust.
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>ts",
                        "<cmd>UltestSummary<CR>",
                        {noremap = true, silent = true}
                    )
                    -- For debugging
                    require("ultest").setup(
                        {
                            builders = {
                                ["ruby#rspec"] = function(cmd)
                                    -- { "bin/rspec", "spec/path/to/file_spec.rb:123"}
                                    local rspec_exec = cmd[1]
                                    local spec_file_path = cmd[2]

                                    return {
                                        dap = {
                                            type = "ruby",
                                            request = "launch",
                                            program = rspec_exec,
                                            programArgs = {spec_file_path}
                                        }
                                    }
                                end
                            }
                        }
                    )

                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tu <cmd>lua SteveUltest()<CR>]])
                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tx :UltestNearest<CR>]])
                    -- vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>l :UltestLast<CR>]])
                    -- vim.cmd([[autocmd FileType ruby nnoremap <silent> <leader>s :TestSuite<CR>]])
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
                ft = {"ruby", "eruby", "rspec"},
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
            use {"tpope/vim-rails", ft = {"ruby", "eruby", "rspec"}}

            -- Its' like rails.vim without the rails
            use {
                "tpope/vim-rake",
                opt = true,
                ft = {"ruby", "eruby"},
                requires = "tpope/vim-projectionist"
            }

            -- Better rspec syntax highlighting for Vim
            use {"sheerun/rspec.vim", ft = {"ruby", "rspec"}}

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
            use {"turboladen/vim-rbs", ft = {"ruby", "rbs", "ruby.rbs", "rspec"}}

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
                "mfussenegger/nvim-lint",
                ft = {"ruby", "vimscript", "vim", "bash", "sh", "zsh"},
                config = function()
                    -- require("turboladen/installers").npm_install("write-good")
                    -- require("turboladen.installers").gem_install("brakeman")
                    -- require("turboladen.installers").gem_install("debride")
                    -- require("turboladen.installers").gem_install("reek")
                    -- require("turboladen.installers").gem_install("sorbet")
                    -- require("turboladen.installers").brew_install("languagetool", "shellcheck")
                    -- require("turboladen.installers").pip_install("vim-vint")

                    local lint = require("lint")

                    -- lint.linters.brakeman = {
                    --   cmd = "brakeman",
                    --   args = {
                    --     "-q", "--faster", "--no-color", "--no-highlights", "--no-pager"
                    --   },
                    --   stream = "stdout",
                    --   parser = function()
                    --     -- Need to figure this out before it'll work.
                    --   end
                    -- }
                    -- lint.linters.debride = {
                    --     cmd = "debride",
                    --     args = {"."},
                    --     stream = "stdout",
                    --     parser = function()
                    --         -- Need to figure this out before it'll work.
                    --     end
                    -- }
                    -- lint.linters.reek = {
                    --     cmd = "reek",
                    --     args = {
                    --         "--format",
                    --         "json",
                    --         "--no-color",
                    --         "--line-numbers",
                    --         "--no-progress"
                    --     },
                    --     stream = "stdout",
                    --     parser = function()
                    --         -- Need to figure this out before it'll work.
                    --     end
                    -- }

                    lint.linters_by_ft = {
                        -- html = {"tidy"},
                        -- lua = {"luacheck", "selene"},
                        -- markdown = {"proselint", "writegood"},
                        -- markdown = {"languagetool"},
                        -- ruby = {"brakeman", "debride", "reek", "ruby", "sorbet"},
                        ruby = {"ruby"},
                        vim = {"vint"},
                        zsh = {"shellcheck"}
                    }

                    vim.cmd([[autocmd BufWritePost ruby,vim,zsh,vimscript,bash,sh <buffer> require('lint').try_lint()]])
                end
            }

            use {
                "mhartington/formatter.nvim",
                ft = {"markdown", "lua", "rust", "ruby"},
                config = function()
                    -- require("turboladen/installers").npm_install("prettier")
                    -- require("turboladen/installers").npm_install("lua-fmt")

                    require("formatter").setup(
                        {
                            filetype = {
                                markdown = {
                                    -- prettier for markdown
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
                                },
                                lua = {
                                    -- luafmt
                                    function()
                                        return {
                                            exe = "luafmt",
                                            args = {"--indent-count", 4, "--stdin"},
                                            stdin = true
                                        }
                                    end
                                },
                                ruby = {
                                    -- rubocop
                                    function()
                                        return {
                                            exe = "rubocop", -- might prepend `bundle exec `
                                            args = {
                                                "--auto-correct",
                                                "--stdin",
                                                "%:p",
                                                "2>/dev/null",
                                                "|",
                                                "awk 'f; /^====================$/{f=1}'"
                                            },
                                            stdin = true
                                        }
                                    end
                                },
                                rust = {
                                    -- Rustfmt
                                    function()
                                        return {
                                            exe = "rustfmt",
                                            args = {"--emit=stdout"},
                                            stdin = true
                                        }
                                    end
                                }
                            }
                        }
                    )

                    vim.api.nvim_exec(
                        [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua,*.rb.*.rs FormatWrite
augroup END
]],
                        true
                    )
                end
            }

            use {
                "mfussenegger/nvim-dap",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                    local dap = require("dap")

                    dap.adapters.ruby = {
                        type = "executable",
                        command = "readapt",
                        args = {"stdio"}
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

                    vim.fn.sign_define("DapBreakpoint", {text = "🛑", texthl = "", linehl = "", numhl = ""})

                    vim.api.nvim_set_keymap(
                        "n",
                        "<F5>",
                        ":lua require('dap').continue()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap("n", "<S-k>", "<cmd>lua require('dap').step_out()<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "<S-l>", "<cmd>lua require('dap').step_into()<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "<S-j>", "<cmd>lua require('dap').step_over()<CR>", {noremap = true})
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>db",
                        "<cmd>lua require('dap').toggle_breakpoint()<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dB",
                        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>lp",
                        "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dr",
                        "<cmd>lua require('dap').repl.open()<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dl",
                        "<cmd>lua require('dap').run_last()<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>di",
                        "<cmd>lua require('dap.ui.variables').hover()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "v",
                        "<leader>di",
                        "<cmd>lua require('dap.ui.variables').visual_hover()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>d?",
                        "<cmd>lua require('dap.ui.variables').scopes()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>de",
                        "<cmd>lua require('dap').set_exception_breakpoints({'all'})<CR>",
                        {noremap = true}
                    )

                    -- au FileType dap-repl lua require('dap.ext.autocompl').attach()
                    vim.cmd [[autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
                end
            }

            use {
                "rcarriga/nvim-dap-ui",
                requires = "mfussenegger/nvim-dap",
                config = function()
                    require("dapui").setup({})

                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dt",
                        ":lua require('dapui').toggle()<CR>",
                        {silent = true, noremap = true}
                    )
                end
            }

            use {
                "neovim/nvim-lspconfig",
                config = function()
                    local lspconfig = require("lspconfig")
                    local lsp_status = require("lsp-status")
                    lsp_status.register_progress()
                    local status_capabilities = lsp_status.capabilities
                    local opts = _MakeLspOpts("solargraph", status_capabilities)

                    lspconfig.solargraph.setup(opts)
                end
            }

            -- use {
            --     "williamboman/nvim-lsp-installer",
            --     requires = {
            --         "neovim/nvim-lspconfig",
            --         "nvim-lua/lsp-status.nvim"
            --     },
            --     config = function()
            --         local function for_each_lsp_server(cb)
            --             -- local server_names = {"sumneko_lua", "jsonls", "vimls", "yamlls"}
            --             local server_names = {"sumneko_lua"}

            --             for _, server_name in pairs(server_names) do
            --                 cb(server_name)
            --             end
            --         end

            --         for_each_lsp_server(
            --             function(server_name)
            --                 local lsp_installer_servers = require("nvim-lsp-installer.servers")
            --                 local ok, server = lsp_installer_servers.get_server(server_name)
            --                 if ok then
            --                     if not server:is_installed() then
            --                         server:install()
            --                     end
            --                 end
            --             end
            --         )

            --         local lsp_installer = require("nvim-lsp-installer")
            --         local lsp_status = require("lsp-status")
            --         lsp_status.register_progress()

            --         lsp_installer.on_server_ready(
            --             function(server)
            --                 local opts = {
            --                     capabilities = lsp_status.capabilities,
            --                     on_attach = function(client, bufnr)
            --                         -- Register client for messages and set up buffer autocommands to update
            --                         -- the statusline and the current function.
            --                         -- NOTE: on_attach is called with the client object, which is the "client" parameter below
            --                         lsp_status.on_attach(client)

            --                         local function buf_set_keymap(...)
            --                             vim.api.nvim_buf_set_keymap(bufnr, ...)
            --                         end
            --                         local function buf_set_option(...)
            --                             vim.api.nvim_buf_set_option(bufnr, ...)
            --                         end

            --                         -- Enable completion triggered by <c-x><c-o>
            --                         buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

            --                         -- Mappings.
            --                         local opts = {noremap = true, silent = true}

            --                         -- See `:help vim.lsp.*` for documentation on any of the below functions
            --                         buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            --                         buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            --                         buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            --                         buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            --                         buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            --                         buf_set_keymap(
            --                             "n",
            --                             "<leader>wa",
            --                             "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
            --                             opts
            --                         )
            --                         buf_set_keymap(
            --                             "n",
            --                             "<leader>wr",
            --                             "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
            --                             opts
            --                         )
            --                         buf_set_keymap(
            --                             "n",
            --                             "<leader>wl",
            --                             "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            --                             opts
            --                         )
            --                         buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
            --                         buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            --                         buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            --                         -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            --                         buf_set_keymap(
            --                             "n",
            --                             "gr",
            --                             "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
            --                             opts
            --                         )
            --                         buf_set_keymap(
            --                             "n",
            --                             "<leader>e",
            --                             "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
            --                             opts
            --                         )
            --                         buf_set_keymap("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
            --                         buf_set_keymap("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
            --                         buf_set_keymap(
            --                             "n",
            --                             "<leader>q",
            --                             "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
            --                             opts
            --                         )
            --                         buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
            --                     end,
            --                     flags = {
            --                         debounce_text_changes = 150
            --                     }
            --                 }

            --                 -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
            --                 vim.cmd [[ do User LspAttachBuffers ]]
            --             end
            --         )
            --     end
            -- }

            use {
                "simrat39/rust-tools.nvim",
                requires = {
                    "neovim/nvim-lspconfig",
                    "nvim-lua/popup.nvim",
                    "nvim-lua/plenary.nvim",
                    "nvim-telescope/telescope.nvim",
                    "mfussenegger/nvim-dap"
                },
                config = function()
                    local lsp_status = require("lsp-status")
                    lsp_status.register_progress()

                    -- Needed to allow for finding lldb and lldb-vscode for DAP.
                    vim.env.PATH = vim.env.PATH .. ":/usr/local/opt/llvm/bin"

                    local status_capabilities = lsp_status.capabilities
                    local server_config = _MakeLspOpts("rust_analyzer", status_capabilities)

                    server_config.settings = {
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

                    -- https://github.com/simrat39/rust-tools.nvim#configuration
                    local rust_tools_opts = {
                        tools = {
                            -- rust-tools options
                            inlay_hints = {
                                show_parameter_hints = false
                            }
                        },
                        -- all the opts to send to nvim-lspconfig
                        -- these override the defaults set by rust-tools.nvim
                        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
                        server = server_config
                    }

                    require("rust-tools").setup(rust_tools_opts)
                end
            }

            use {
                "kosayoda/nvim-lightbulb",
                config = function()
                    vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
                end
            }

            use {
                "nvim-telescope/telescope.nvim",
                requires = {
                    "nvim-lua/plenary.nvim",
                    "kyazdani42/nvim-web-devicons",
                    "nvim-treesitter/nvim-treesitter"
                },
                config = function()
                    require("telescope").setup(
                        {
                            pickers = {
                                find_files = {
                                    theme = "ivy"
                                },
                                lsp_code_actions = {
                                    theme = "cursor"
                                }
                            }
                        }
                    )

                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader><leader>",
                        "<cmd>lua require('telescope.builtin').find_files()<CR>",
                        {noremap = true}
                    )

                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader><CR>",
                        "<cmd>lua require('telescope.builtin').buffers()<CR>",
                        {noremap = true}
                    )

                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>fg",
                        "<cmd>lua require('telescope.builtin').live_grep()<CR>",
                        {noremap = true}
                    )

                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>fk",
                        "<cmd>lua require('telescope.builtin').grep_string()<CR>",
                        {noremap = true}
                    )

                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>fm",
                        "<cmd>lua require('telescope.builtin').marks()<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>fo",
                        "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
                        {noremap = true}
                    )
                end
            }

            -- Lua
            use {
                "folke/trouble.nvim",
                requires = {
                    "kyazdani42/nvim-web-devicons"
                    -- "nvim-telescope/telescope.nvim"
                },
                config = function()
                    require("trouble").setup(
                        {
                            auto_preview = false
                        }
                    )

                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>a",
                        "<cmd>Trouble lsp_workspace_diagnostics<cr>",
                        {silent = true, noremap = true}
                    )

                    -- jump to the next item, skipping the groups
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>]",
                        "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>",
                        {silent = true, noremap = true}
                    )

                    -- jump to the previous item, skipping the groups
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>[",
                        "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>",
                        {silent = true, noremap = true}
                    )
                end
            }

            use {
                "hrsh7th/nvim-cmp",
                requires = {
                    "neovim/nvim-lspconfig",
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/vim-vsnip",
                    "hrsh7th/cmp-vsnip",
                    "rafamadriz/friendly-snippets",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-nvim-lua",
                    -- https://github.com/onsails/lspkind-nvim
                    "onsails/lspkind-nvim"
                },
                config = function()
                    local cmp = require("cmp")
                    local lspkind = require("lspkind")
                    local lsp_status = require("lsp-status")

                    cmp.setup(
                        {
                            completion = {
                                keyword_length = 2
                            },
                            formatting = {
                                format = lspkind.cmp_format({with_text = true})
                            },
                            mapping = {
                                ["<C-j>"] = cmp.mapping.select_next_item(),
                                ["<C-k>"] = cmp.mapping.select_prev_item(),
                                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                                ["<C-space>"] = cmp.mapping.complete(),
                                ["<C-e>"] = cmp.mapping.close(),
                                ["<CR>"] = cmp.mapping.confirm({select = true})
                            },
                            snippet = {
                                expand = function(args)
                                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
                                end
                            },
                            sources = {
                                {name = "nvim_lsp", priority = 2},
                                {name = "vsnip", priority = 2},
                                {name = "buffer", max_item_count = 5},
                                {name = "path", max_item_count = 5},
                                {name = "nvim_lua"},
                                {name = "crates"}
                            }
                        }
                    )

                    -- Setup lspconfig.
                    local server_names = require("lspconfig").available_servers()
                    local capabilities = lsp_status.capabilities

                    for _, server_name in pairs(server_names) do
                        require("lspconfig")[server_name].setup {
                            capabilities = vim.tbl_extend(
                                "keep",
                                require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
                                capabilities
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

                    vim.api.nvim_set_keymap(
                        "n",
                        "K",
                        "<cmd>lua ShowDocumentation()<CR>",
                        {noremap = true, silent = true}
                    )
                end
            }

            use {"andymass/vim-matchup", event = "VimEnter"}

            -- Use dependency and run lua function after load
            use {
                "lewis6991/gitsigns.nvim",
                requires = {"nvim-lua/plenary.nvim"},
                config = function()
                    require("gitsigns").setup(
                        {
                            current_line_blame = true,
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

            use {
                "lewis6991/spellsitter.nvim",
                config = function()
                    require("spellsitter").setup({})
                end
            }

            use {
                "Shatur/neovim-session-manager",
                requires = "nvim-telescope/telescope.nvim",
                config = function()
                    require("session_manager").setup({})
                    require("telescope").load_extension("sessions")
                end
            }
        end,
        config = {
            max_jobs = 20
        }
    }
)
