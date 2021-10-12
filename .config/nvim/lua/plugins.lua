-- This file can be loaded by calling `lua require('plugins')` from your init.vim

function HlsLensNext()
    vim.cmd([[execute('normal! ' . v:count1 . 'n') | lua require('hlslens').start()]])
end

function HlsLensPrev()
    vim.cmd([[execute('normal! ' . v:count1 . 'N') | lua require('hlslens').start()]])
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
            -- https://github.com/tpope/vim-repeat
            use "tpope/vim-repeat"

            ------------------------------------------------------------------------------
            -- UI tweaks
            ------------------------------------------------------------------------------
            -- Treesitter configurations and abstraction layer for Neovim.
            -- https://github.com/nvim-treesitter/nvim-treesitter
            use {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                config = function()
                    require("nvim-treesitter.configs").setup(
                        {
                            ensure_installed = {
                                "bash",
                                "c",
                                "cmake",
                                "comment",
                                "cpp",
                                "dockerfile",
                                "elixir",
                                "elm",
                                "html",
                                "javascript",
                                "json",
                                "json5",
                                "jsonc",
                                "llvm",
                                "lua",
                                "ruby",
                                "rust",
                                "toml",
                                "typescript",
                                "vim",
                                "yaml"
                            },
                            highlight = {enable = true},
                            matchup = {enable = true}
                        }
                    )
                end
            }

            -- https://github.com/p00f/nvim-ts-rainbow
            -- 🌈 Rainbow parentheses for neovim using tree-sitter 🌈
            use {
                "p00f/nvim-ts-rainbow",
                requires = {
                    "nvim-lua/plenary.nvim",
                    "nvim-telescope/telescope.nvim"
                },
                config = function()
                    require("nvim-treesitter.configs").setup {
                        rainbow = {
                            enable = true,
                            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                            max_file_lines = nil -- Do not enable for files with more than n lines, int
                            -- colors = {}, -- table of hex strings
                            -- termcolors = {} -- table of colour name strings
                        }
                    }
                end
            }

            -- Neovim treesitter plugin for setting the commentstring based on
            -- the cursor location in a file.
            -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
            use {
                "JoosepAlviste/nvim-ts-context-commentstring",
                requires = {
                    "nvim-telescope/telescope.nvim",
                    "tpope/vim-commentary"
                },
                config = function()
                    require("nvim-treesitter.configs").setup {
                        context_commentstring = {
                            enable = true,
                            config = {
                                rust = "// %s"
                            }
                        }
                    }
                end
            }

            -- Enhanced terminal integration for Vim.
            -- https://github.com/wincent/terminus
            use "wincent/terminus"

            -- A completion plugin for neovim coded in Lua.
            -- https://github.com/hrsh7th/nvim-cmp
            use {
                "hrsh7th/nvim-cmp",
                requires = {
                    "neovim/nvim-lspconfig",
                    "nvim-lua/lsp-status.nvim",
                    -- https://github.com/onsails/lspkind-nvim
                    "onsails/lspkind-nvim",
                    -- nvim-cmp source for neovim builtin LSP client.
                    -- https://github.com/hrsh7th/cmp-nvim-lsp
                    "hrsh7th/cmp-nvim-lsp",
                    -- VSCode(LSP)'s snippet feature in vim.
                    -- https://github.com/hrsh7th/vim-vsnip
                    "hrsh7th/vim-vsnip",
                    -- https://github.com/hrsh7th/cmp-buffer
                    "hrsh7th/cmp-buffer",
                    -- https://github.com/hrsh7th/vim-vsnip
                    "hrsh7th/cmp-vsnip",
                    -- https://github.com/rafamadriz/friendly-snippets
                    "rafamadriz/friendly-snippets",
                    -- https://github.com/hrsh7th/cmp-path
                    "hrsh7th/cmp-path",
                    -- nvim-cmp source for neovim Lua API.
                    -- https://github.com/hrsh7th/cmp-nvim-lua
                    "hrsh7th/cmp-nvim-lua"
                },
                config = function()
                    local cmp = require("cmp")
                    local lspkind = require("lspkind")
                    local lsp_status = require("lsp-status")

                    vim.g.vsnip_filetypes = {
                        rails = {"ruby", "rails"},
                        rspec = {"ruby", "rails", "rspec"}
                    }

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

            -- LSP signature hint as you type
            -- https://github.com/ray-x/lsp_signature.nvim
            use {
                "ray-x/lsp_signature.nvim"
            }

            use {
                "Saecki/crates.nvim",
                event = {"BufEnter Cargo.toml"},
                requires = {"nvim-lua/plenary.nvim"},
                config = function()
                    require("crates").setup()
                    vim.cmd([[autocmd BufEnter Cargo.toml nnoremap <silent> K <cmd>lua ShowDocumentation()<CR>]])
                end
            }

            -- Use dependency and run lua function after load
            use {
                "lewis6991/gitsigns.nvim",
                requires = {"nvim-lua/plenary.nvim"},
                event = "BufRead",
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

            use {
                "lewis6991/spellsitter.nvim",
                config = function()
                    require("spellsitter").setup({})
                end
            }

            -- vim-signature is a plugin to place, toggle and display marks.
            -- https://github.com/kshenoy/vim-signature
            use "kshenoy/vim-signature"

            -- Distraction-free writing in Vim.
            -- https://github.com/junegunn/goyo.vim
            use {"junegunn/goyo.vim", config = "vim.g.goyo_width = 101", cmd = "Goyo"}

            -- A good looking and efficient status line.
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

            use {
                "simrat39/symbols-outline.nvim",
                config = function()
                    vim.api.nvim_set_keymap("n", "<leader>s", ":SymbolsOutline<CR>", {noremap = true, silent = true})
                end
            }
            -----------------------------------------------------------------------------
            -- 2. moving around, searching and patterns
            -----------------------------------------------------------------------------
            -- Use RipGrep in Vim and display results in a quickfix list
            use {
                "jremmen/vim-ripgrep",
                command = "Rg",
                config = function()
                    vim.g.rg_command = "rg --vimgrep --ignore-vcs"
                    vim.g.rg_highlight = 1

                    vim.api.nvim_set_keymap("n", "<leader>.", ":Rg<SPACE>", {noremap = true})
                end
            }

            -- pairs of handy bracket mappings
            -- https://github.com/tpope/vim-unimpaired
            use "tpope/vim-unimpaired"

            -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text. It extends vim's % key to language-specific words instead of just single characters.
            -- https://github.com/andymass/vim-matchup
            use {"andymass/vim-matchup", event = "VimEnter"}

            -- Directory viewer for Vim
            -- https://github.com/justinmk/vim-dirvish
            use "justinmk/vim-dirvish"
            use {"kristijanhusak/vim-dirvish-git", requires = {"justinmk/vim-dirvish"}}

            -- Change code right in the quickfix window
            -- https://github.com/stefandtw/quickfix-reflector.vim
            use "stefandtw/quickfix-reflector.vim"

            -- https://github.com/kevinhwang91/nvim-hlslens
            use {
                "kevinhwang91/nvim-hlslens",
                config = function()
                    vim.api.nvim_set_keymap("n", "n", "<cmd>lua HlsLensNext()<CR>", {silent = true, noremap = true})
                    vim.api.nvim_set_keymap("n", "N", "<cmd>lua HlsLensPrev()<CR>", {silent = true, noremap = true})
                    vim.api.nvim_set_keymap("n", "*", "*<cmd>lua require('hlslens').start()<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "#", "#<cmd>lua require('hlslens').start()<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "g*", "g*<cmd>lua require('hlslens').start()<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "g#", "g#<cmd>lua require('hlslens').start()<CR>", {noremap = true})
                end
            }

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

            -- https://github.com/adisen99/codeschool.nvim
            use {
                "adisen99/codeschool.nvim",
                requires = "rktjmp/lush.nvim",
                config = function()
                    vim.g.codeschool_contrast_dark = "hard"
                    vim.g.codeschool_italic = 1
                    -- vim.g.codeschool_sign_column = "none"
                    -- vim.g.codeschool_color_column = "none"
                    vim.g.codeschool_invert_signs = 1
                    vim.g.codeschool_invert_indent_guides = 1
                    vim.g.codeschool_improved_strings = 1
                    vim.g.codeschool_improved_warnings = 1
                    vim.g.codeschool_transparent_bg = 1
                    vim.g.codeschool_underline = 0
                    vim.g.codeschool_undercurl = 0

                    require("lush")(
                        require("codeschool").setup(
                            {
                                plugins = {
                                    "buftabline",
                                    "fzf",
                                    "gitsigns",
                                    "lsp",
                                    "telescope",
                                    "treesitter"
                                },
                                langs = {
                                    "c",
                                    "css",
                                    "elixir",
                                    "html",
                                    "js",
                                    "json",
                                    "lua",
                                    "markdown",
                                    "python",
                                    "rust",
                                    "typescript",
                                    "viml",
                                    "xml"
                                }
                            }
                        )
                    )
                end
            }

            use "nxvu699134/vn-night.nvim"
            -- use {
            --     "sainnhe/everforest",
            --     config = function()
            --         vim.g.everforest_background = "medium"
            --         vim.g.everforest_enable_italic = 1
            --         vim.g.everforest_transparent_background = 1
            --         vim.g.everforest_ui_contrast = "high"
            --         vim.g.everforest_diagnostic_text_highlight = 1
            --         vim.g.everforest_diagnostic_line_highlight = 1
            --         vim.g.everforest_diagnostic_virtual_text = "colored"
            --     end
            -- }

            -- https://github.com/Pocco81/Catppuccino.nvim
            -- use "Pocco81/Catppuccino.nvim"
            use {
                "marko-cerovac/material.nvim",
                config = function()
                    vim.g.material_style = "darker"
                    -- vim.g.material_style = "deep ocean"
                    -- vim.g.material_style = "lighter"
                end
            }

            -- Hyperfocus-writing in Vim
            -- https://github.com/junegunn/limelight.vim
            use {
                "junegunn/limelight.vim",
                config = "vim.g.limelight_paragraph_span = 1",
                cmd = "Limelight"
            }

            -- Show vertical line for indentation level
            -- https://github.com/lukas-reineke/indent-blankline.nvim
            use {
                "lukas-reineke/indent-blankline.nvim",
                ft = {"yaml", "json"},
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
            -- https://github.com/rstacruz/vim-closer
            -- https://github.com/tpope/vim-endwise
            use {"rstacruz/vim-closer", requires = "tpope/vim-endwise"}

            -- comment stuff out
            -- https://github.com/tpope/vim-commentary
            use "tpope/vim-commentary"

            -- quoting/parenthesizing made simple
            -- https://github.com/tpope/vim-surround
            use "tpope/vim-surround"

            -- Adds gS and gJ to split/join code blocks.
            -- https://github.com/AndrewRadev/splitjoin.vim
            use "AndrewRadev/splitjoin.vim"

            -- Easy text exchange operator
            -- https://github.com/tommcdo/vim-exchange
            use "tommcdo/vim-exchange"

            -- Protect against weird unicode copy/paste
            -- https://github.com/vim-utils/vim-troll-stopper
            use {
                "vim-utils/vim-troll-stopper",
                config = function()
                    vim.cmd([[highlight TrollStopper ctermbg = red guibg = #FF0000
]])
                end
            }

            -- For case swapping
            -- https://github.com/idanarye/vim-casetrate
            use {
                "idanarye/vim-casetrate",
                cmd = "Casetrate"
            }

            -- Vim script for text filtering and alignment
            -- https://github.com/godlygeek/tabular
            use {"godlygeek/tabular", cmd = "Tabularize"}

            --===========================================================================
            -- 21. executing external commands
            --===========================================================================
            -- Asynchronous build and test dispatcher. Used for running specs in a separate
            -- tmux pane.
            -- https://github.com/tpope/vim-dispatch
            use {"tpope/vim-dispatch", cmd = {"Dispatch", "Make", "Focus", "Start"}}

            -- Vim sugar for the UNIX shell commands that need it the most
            -- https://github.com/tpope/vim-eunuch
            use {
                "tpope/vim-eunuch",
                cmd = {"Delete", "Unlink", "Move", "Rename", "Remove", "Mkdir"}
            }

            --===========================================================================
            -- 22. running make and jumping to errors (quickfix)
            --===========================================================================
            -- run your tests at the speed of thought
            -- https://github.com/vim-test/vim-test
            -- https://github.com/voldikss/vim-floaterm
            use {
                "vim-test/vim-test",
                requires = {"tpope/vim-dispatch", "voldikss/vim-floaterm"},
                ft = {"rust", "ruby"},
                config = function()
                    vim.g["test#strategy"] = {
                        nearest = "floaterm",
                        last = "floaterm",
                        file = "dispatch",
                        suite = "dispatch"
                    }
                    vim.g["test#preserve_screen"] = 1
                    vim.g["test#enabled_runners"] = {
                        "ruby#rspec",
                        "ruby#rails",
                        "rust#cargotest"
                    }

                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tn <cmd>TestNearest<CR>]])
                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tf <cmd>TestFile<CR>]])
                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>ta <cmd>TestSuite<CR>]])
                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tl <cmd>TestLast<CR>]])
                    vim.cmd([[autocmd FileType ruby,rust nnoremap <silent> <leader>tv <cmd>TestVisit<CR>]])
                end
            }

            --===========================================================================
            -- 23. language specific
            --===========================================================================
            -- A solid language pack for Vim.
            -- https://github.com/sheerun/vim-polyglot
            use {
                "sheerun/vim-polyglot",
                requires = {
                    "godlygeek/tabular"
                },
                config = function()
                    -- vim-json
                    vim.g.vim_json_syntax_conceal = false

                    -- vim-markdown
                    vim.g.vim_markdown_folding_disabled = 1
                    vim.g.vim_markdown_conceal = 0
                    vim.g.vim_markdown_follow_anchor = 1
                    vim.g.vim_markdown_new_list_item_indent = 2
                    vim.g.vim_markdown_no_default_key_mappings = 1
                    vim.g.vim_markdown_strikethrough = 1

                    -- vim-ruby
                    vim.g.ruby_operators = 1
                    vim.g.ruby_spellcheck_strings = 1
                    vim.g.ruby_space_errors = 1

                    vim.g.rubycomplete_buffer_loading = 1
                    vim.g.rubycomplete_classes_in_global = 1
                    vim.g.rubycomplete_load_gemfile = 1

                    -- vim-yardoc
                    -- vim.cmd("hi link yardGenericTag rubyInstanceVariable")
                    -- vim.cmd("hi link yardTypeList rubyConstant")
                    -- vim.cmd("hi link yardType rubyConstant")
                end
            }

            ------------------
            -- Elixir
            ------------------
            use {"avdgaag/vim-phoenix", opt = true, ft = {"elixir", "eelixir"}}

            ------------------
            -- Git
            ------------------
            -- a Git wrapper so awesome, it should be illegal
            use {
                "tpope/vim-fugitive",
                config = function()
                    vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Git<CR>", {silent = true})
                end
            }

            -- If fugitive.vim is the Git, rhubarb.vim is the Hub.
            use "tpope/vim-rhubarb"

            -- A Vim plugin for more pleasant editing on commit messages
            -- https://github.com/rhysd/committia.vim
            use {
                "rhysd/committia.vim",
                config = function()
                    vim.g.committia_hooks = {}

                    vim.g.committia_hooks.edit_open = function(info)
                        vim.opt_local.spell = true

                        -- If no commit message, start with insert mode
                        if info.vcs == "git" and vim.fn.getline(1) == "" then
                            vim.fn.startinsert()
                        end
                    end
                end
            }

            ------------------
            -- HTML
            ------------------
            -- emmet for vim
            use {"mattn/emmet-vim", opt = true, ft = {"html", "html.*"}}

            ------------------
            -- JS
            ------------------
            -- Enhanced javascript syntax file
            use {"jelera/vim-javascript-syntax", opt = true, ft = "javascript"}

            ------------------
            -- Ruby
            ------------------
            -- Ruby on Rails power tools
            use {"tpope/vim-rails", ft = {"ruby", "eruby", "rspec"}}

            -- Its' like rails.vim without the rails
            use {
                "tpope/vim-rake",
                opt = true,
                ft = {"ruby", "eruby"},
                requires = "tpope/vim-projectionist"
            }

            -- use '~/Development/projects/vim-rbs'
            use {"turboladen/vim-rbs", ft = {"ruby", "rbs", "ruby.rbs", "rspec"}}

            ------------------
            -- tmux
            ------------------
            -- Syntax, navigation, building
            use "tmux-plugins/vim-tmux"

            -- Restores `FocusGained` and `FocusLost` autocommand events work when using
            -- vim inside Tmux.
            use "tmux-plugins/vim-tmux-focus-events"

            ------------------
            -- YAML
            ------------------
            use {"stephpy/vim-yaml", ft = "yaml"}

            --===========================================================================
            -- 25. various
            --===========================================================================
            -- plenary: full; complete; entire; absolute; unqualified. All the lua
            -- functions I don't want to write twice.
            -- https://github.com/nvim-lua/plenary.nvim/
            use "nvim-lua/plenary.nvim"

            --  An asynchronous linter plugin for Neovim (>= 0.5) complementary
            --  to the built-in Language Server Protocol support.
            -- https://github.com/mfussenegger/nvim-lint
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
                    --     cmd = "brakeman",
                    --     args = {
                    --         "-q",
                    --         "--faster",
                    --         "--no-color",
                    --         "--no-highlights",
                    --         "--no-pager"
                    --     },
                    --     stream = "stdout",
                    --     parser = function()
                    --         -- Need to figure this out before it'll work.
                    --     end
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
                ft = {"markdown", "lua"},
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
                                }
                            }
                        }
                    )

                    vim.api.nvim_exec(
                        [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua FormatWrite
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
                        "<cmd>lua require('dap').continue()<CR>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dk",
                        "<cmd>lua require('dap').step_out()<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dl",
                        "<cmd>lua require('dap').step_into()<CR>",
                        {noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>dj",
                        "<cmd>lua require('dap').step_over()<CR>",
                        {noremap = true}
                    )
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
                        "<leader>dL",
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
                        "<cmd>lua require('dapui').toggle()<CR>",
                        {silent = true, noremap = true}
                    )
                end
            }

            -- https://github.com/nvim-lua/lsp-status.nvim
            use {
                "neovim/nvim-lspconfig",
                requires = "nvim-lua/lsp-status.nvim",
                config = function()
                    require("turboladen.lsp").setup_lsp()

                    vim.cmd(
                        [[
  augroup lsp_format_config
    autocmd!
    autocmd BufWritePost * lua vim.lsp.buf.formatting_sync()
  augroup end
]]
                    )
                end
            }

            -- Tools for better development in rust using neovim's builtin lsp
            -- https://github.com/simrat39/rust-tools.nvim
            use {
                "simrat39/rust-tools.nvim",
                requires = {
                    "neovim/nvim-lspconfig",
                    "nvim-lua/popup.nvim",
                    "nvim-lua/plenary.nvim",
                    "nvim-telescope/telescope.nvim",
                    "mfussenegger/nvim-dap",
                    "nvim-lua/lsp-status.nvim"
                },
                after = "nvim-lspconfig",
                config = function()
                    local lsp_status = require("lsp-status")
                    lsp_status.register_progress()

                    -- Needed to allow for finding lldb and lldb-vscode for DAP.
                    vim.env.PATH = vim.env.PATH .. ":/usr/local/opt/llvm/bin"

                    -- https://github.com/simrat39/rust-tools.nvim#configuration
                    local rust_tools_opts = {
                        tools = {
                            crate_graph = {
                                full = false
                            },
                            inlay_hints = {
                                only_current_line = true
                            }
                        },
                        -- all the opts to send to nvim-lspconfig
                        -- these override the defaults set by rust-tools.nvim
                        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
                        server = {
                            on_attach = require("turboladen.lsp").make_on_attach("rust_analyzer"),
                            capabilities = require("turboladen.lsp").make_capabilities(),
                            flags = require("turboladen.lsp").make_flags(),
                            settings = {
                                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                                ["rust-analyzer"] = {
                                    assist = {
                                        importPrefix = "by_self"
                                    },
                                    cargo = {
                                        allFeatures = true
                                    },
                                    checkOnSave = {
                                        command = "clippy"
                                    },
                                    hoverActions = {
                                        references = true
                                    }
                                    -- lens = {
                                    --     references = true,
                                    --     methodReferences = true
                                    -- }
                                }
                            }
                        }
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
                                buffers = {
                                    theme = "cursor",
                                    previewer = false
                                },
                                find_files = {
                                    theme = "dropdown"
                                },
                                lsp_code_actions = {
                                    theme = "cursor"
                                },
                                oldfiles = {
                                    theme = "dropdown"
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
                        "<leader>/",
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
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>ft",
                        "<cmd>lua require('telescope.builtin').grep_string({ search = 'TODO' })<CR>",
                        {noremap = true}
                    )
                end
            }

            use {
                "nvim-telescope/telescope-symbols.nvim",
                requires = "nvim-telescope/telescope.nvim"
            }

            -- Lua
            use {
                "folke/trouble.nvim",
                requires = "kyazdani42/nvim-web-devicons",
                config = function()
                    require("trouble").setup(
                        {
                            auto_preview = false
                        }
                    )
                    -- Lua
                    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>xw",
                        "<cmd>Trouble lsp_workspace_diagnostics<cr>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>xd",
                        "<cmd>Trouble lsp_document_diagnostics<cr>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>xl",
                        "<cmd>Trouble loclist<cr>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>xq",
                        "<cmd>Trouble quickfix<cr>",
                        {silent = true, noremap = true}
                    )
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>xr",
                        "<cmd>Trouble refresh<cr>",
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
                "xiyaowong/telescope-emoji.nvim",
                requires = "nvim-telescope/telescope.nvim",
                config = function()
                    require("telescope").load_extension("emoji")
                end
            }

            -- https://github.com/nvim-telescope/telescope-github.nvim
            -- Requires `gh` and don't forget to auth the first use!
            use {
                "nvim-telescope/telescope-github.nvim",
                requires = {
                    "nvim-lua/plenary.nvim",
                    "nvim-telescope/telescope.nvim"
                },
                config = function()
                    require("telescope").load_extension("gh")

                    vim.api.nvim_set_keymap("n", "<leader>ghi", "<cmd>Telescope gh issues<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "<leader>ghp", "<cmd>Telescope gh pull_request<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "<leader>ghg", "<cmd>Telescope gh gist<CR>", {noremap = true})
                    vim.api.nvim_set_keymap("n", "<leader>ghr", "<cmd>Telescope gh run<CR>", {noremap = true})
                end
            }

            use {
                "sudormrfbin/cheatsheet.nvim"
            }

            -- A small automated session manager for Neovim
            -- https://github.com/rmagatti/auto-session
            use {
                "rmagatti/auto-session",
                requires = "Asheq/close-buffers.vim",
                config = function()
                    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,resize,winpos,terminal"

                    require("auto-session").setup(
                        {
                            pre_save_cmds = {
                                "tabdo SymbolsOutlineClose",
                                ":Bdelete hidden"
                            },
                            auto_save_enabled = true
                        }
                    )
                end
            }
        end,
        config = {
            max_jobs = 20
        }
    }
)
