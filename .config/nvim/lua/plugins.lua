function GetSetup(name)
    return string.format('require("setup/%s")', name)
end

local disable_treesitter = false

return require("packer").startup({
    function(use)
        -- https://github.com/wbthomason/packer.nvim
        use({ "wbthomason/packer.nvim", config = GetSetup("packer") })

        -----------------------------------------------------------------------------
        -- 0.
        -----------------------------------------------------------------------------
        -- Enable repeating supported plugin maps with '.'
        -- https://github.com/tpope/vim-repeat
        use("tpope/vim-repeat")

        -- This plugin is a replacement for the included filetype.vim that is sourced on startup.
        -- https://github.com/nathom/filetype.nvim
        use({ "nathom/filetype.nvim" })

        ------------------------------------------------------------------------------
        -- UI tweaks
        ------------------------------------------------------------------------------
        -- Treesitter configurations and abstraction layer for Neovim.
        -- https://github.com/nvim-treesitter/nvim-treesitter
        -- https://github.com/p00f/nvim-ts-rainbow
        -- 🌈 Rainbow parentheses for neovim using tree-sitter 🌈
        -- Neovim treesitter plugin for setting the commentstring based on
        -- the cursor location in a file.
        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        use({
            "nvim-treesitter/nvim-treesitter",
            disable = disable_treesitter,
            run = ":TSUpdate",
            requires = {
                "p00f/nvim-ts-rainbow",
                "JoosepAlviste/nvim-ts-context-commentstring",
                "tpope/vim-commentary", -- <- for ^^
            },
            config = GetSetup("nvim-treesitter"),
        })

        -- Lightweight alternative to context.vim implemented with nvim-treesitter.
        use({
            "romgrk/nvim-treesitter-context",
            disable = disable_treesitter,
            requires = { "nvim-treesitter/nvim-treesitter" },
            config = GetSetup("nvim-treesitter-context"),
        })

        -- Enhanced terminal integration for Vim.
        -- https://github.com/wincent/terminus
        use("wincent/terminus")

        -- A completion plugin for neovim coded in Lua.
        -- https://github.com/hrsh7th/nvim-cmp
        use({
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
                -- https://github.com/hrsh7th/vim-vsnip
                "hrsh7th/cmp-vsnip",
                "rafamadriz/friendly-snippets",
                -- https://github.com/hrsh7th/cmp-buffer
                "hrsh7th/cmp-buffer",
                -- https://github.com/hrsh7th/cmp-path
                "hrsh7th/cmp-path",
                -- nvim-cmp source for neovim Lua API.
                -- https://github.com/hrsh7th/cmp-nvim-lua
                "hrsh7th/cmp-nvim-lua",
                "saecki/crates.nvim",
                "lukas-reineke/cmp-rg",
            },
            config = GetSetup("nvim-cmp"),
        })

        -- Use dependency and run lua function after load
        use({
            "lewis6991/gitsigns.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = GetSetup("gitsigns-nvim"),
        })

        -- https://github.com/TimUntersberger/neogit
        use({
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
            config = GetSetup("neogit"),
        })

        -- https://github.com/lewis6991/spellsitter.nvim
        -- Enable Neovim's builtin spellchecker for buffers with tree-sitter highlighting.
        use({ "lewis6991/spellsitter.nvim", config = GetSetup("spellsitter-nvim") })

        -- Distraction-free writing in Vim.
        -- https://github.com/junegunn/goyo.vim
        use({ "junegunn/goyo.vim", config = GetSetup("goyo-vim"), cmd = "Goyo" })

        -- A good looking and efficient status line.
        -- https://github.com/datwaft/bubbly.nvim
        use({
            "datwaft/bubbly.nvim",
            requires = "nvim-lua/lsp-status.nvim",
            config = GetSetup("bubbly-nvim"),
        })

        use({
            "saecki/crates.nvim",
            tag = "v0.1.0",
            requires = { "nvim-lua/plenary.nvim" },
            event = { "BufRead Cargo.toml" },
            config = GetSetup("crates-nvim"),
        })

        use({
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup({
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                })
            end,
        })

        -----------------------------------------------------------------------------
        -- 2. moving around, searching and patterns
        -----------------------------------------------------------------------------
        -- Use RipGrep in Vim and display results in a quickfix list
        use({ "jremmen/vim-ripgrep", command = "Rg", config = GetSetup("vim-ripgrep") })

        -- pairs of handy bracket mappings
        -- https://github.com/tpope/vim-unimpaired
        use("tpope/vim-unimpaired")

        use("Raimondi/delimitMate")

        -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text. It extends vim's % key to language-specific words instead of just single characters.
        -- https://github.com/andymass/vim-matchup
        use({
            "andymass/vim-matchup",
            event = "VimEnter",
            config = GetSetup("vim-matchup"),
        })

        -- Directory viewer for Vim
        -- https://github.com/justinmk/vim-dirvish
        use("justinmk/vim-dirvish")
        use({ "kristijanhusak/vim-dirvish-git", requires = { "justinmk/vim-dirvish" } })

        -- Change code right in the quickfix window
        -- https://github.com/stefandtw/quickfix-reflector.vim
        use("stefandtw/quickfix-reflector.vim")

        -- https://github.com/kevinhwang91/nvim-hlslens
        use({ "kevinhwang91/nvim-hlslens" })

        -- Extensible Neovim Scrollbar
        use({
            "petertriho/nvim-scrollbar",
            config = GetSetup("nvim-scrollbar"),
        })

        --===========================================================================
        -- 5. syntax, highlighting and spelling
        --===========================================================================
        ----------------------------------------
        -- colorschemes
        ----------------------------------------
        -- https://github.com/Mangeshrex/uwu.vim
        use("mangeshrex/uwu.vim")

        use("aonemd/kuroi.vim")
        use({ "sainnhe/edge", config = GetSetup("edge") })

        -- https://github.com/savq/melange
        use("savq/melange")

        -- https://github.com/EdenEast/nightfox.nvim
        use({ "EdenEast/nightfox.nvim", config = GetSetup("nightfox-nvim") })

        -- https://github.com/novakne/kosmikoa.nvim
        use("novakne/kosmikoa.nvim")

        -- https://github.com/rakr/vim-one
        use({
            "rakr/vim-one",
            config = GetSetup("vim-one"),
        })

        -- https://github.com/adisen99/codeschool.nvim
        use({
            "adisen99/codeschool.nvim",
            requires = { "rktjmp/lush.nvim" },
            disable = true,
            config = GetSetup("codeschool-nvim"),
        })

        use({
            "sainnhe/everforest",
            config = GetSetup("everforest"),
        })

        -- https://github.com/marko-cerovac/material.nvim
        use({
            "marko-cerovac/material.nvim",
            config = GetSetup("material-nvim"),
        })

        -- Hyperfocus-writing in Vim
        -- https://github.com/junegunn/limelight.vim
        use({
            "junegunn/limelight.vim",
            cmd = "Limelight",
            config = GetSetup("limelight-vim"),
        })

        -- Show vertical line for indentation level
        -- https://github.com/lukas-reineke/indent-blankline.nvim
        use({
            "lukas-reineke/indent-blankline.nvim",
            config = GetSetup("indent-blankline-nvim"),
        })

        --===========================================================================
        -- 6. multiple windows
        --===========================================================================
        -- Delete all the buffers except the current/named buffer
        use({ "vim-scripts/BufOnly.vim", cmd = "BufOnly" })

        --===========================================================================
        -- 13. editing text
        --===========================================================================
        -- Closes brackets. Perfect companion to vim-endwise. Basically, a more
        -- conservative version of auto-pairs that only works when you press Enter.
        -- https://github.com/rstacruz/vim-closer
        -- use({ "rstacruz/vim-closer", requires = "tpope/vim-endwise" })

        -- https://github.com/tpope/vim-endwise
        use({ "tpope/vim-endwise" })

        -- https://github.com/numToStr/Comment.nvim
        use({
            "numToStr/Comment.nvim",
            config = GetSetup("Comment-nvim"),
        })

        -- quoting/parenthesizing made simple
        -- https://github.com/tpope/vim-surround
        use("tpope/vim-surround")

        -- Adds gS and gJ to split/join code blocks.
        -- https://github.com/AndrewRadev/splitjoin.vim
        use("AndrewRadev/splitjoin.vim")

        -- Easy text exchange operator
        -- https://github.com/tommcdo/vim-exchange
        use("tommcdo/vim-exchange")

        -- Protect against weird unicode copy/paste
        -- https://github.com/vim-utils/vim-troll-stopper
        use({
            "vim-utils/vim-troll-stopper",
            config = GetSetup("vim-troll-stopper"),
        })

        -- For case swapping
        -- https://github.com/idanarye/vim-casetrate
        use({
            "idanarye/vim-casetrate",
            cmd = "Casetrate",
        })

        -- Vim script for text filtering and alignment
        -- https://github.com/godlygeek/tabular
        use({ "godlygeek/tabular", cmd = "Tabularize" })

        --===========================================================================
        -- 21. executing external commands
        --===========================================================================
        -- Asynchronous build and test dispatcher. Used for running specs in a separate
        -- tmux pane.
        -- https://github.com/tpope/vim-dispatch
        use({ "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } })

        -- Vim sugar for the UNIX shell commands that need it the most
        -- https://github.com/tpope/vim-eunuch
        use({
            "tpope/vim-eunuch",
            cmd = { "Delete", "Unlink", "Move", "Rename", "Remove", "Mkdir" },
        })

        --===========================================================================
        -- 22. running make and jumping to errors (quickfix)
        --===========================================================================
        -- run your tests at the speed of thought
        -- https://github.com/vim-test/vim-test
        -- https://github.com/voldikss/vim-floaterm
        use({
            "vim-test/vim-test",
            requires = { "tpope/vim-dispatch", "voldikss/vim-floaterm" },
            cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit", "Ultest" },
            config = GetSetup("vim-test"),
        })

        use({
            "rcarriga/vim-ultest",
            disable = true,
            requires = "vim-test/vim-test",
            run = ":UpdateRemotePlugins",
            cmd = { "Ultest", "UltestSummary" },
            config = GetSetup("vim-ultest"),
        })

        --===========================================================================
        -- 23. language specific
        --===========================================================================
        -- A solid language pack for Vim.
        -- https://github.com/sheerun/vim-polyglot
        -- use {
        --     "sheerun/vim-polyglot",
        --     requires = {
        --         "godlygeek/tabular"
        --     },
        --     config = function()
        --         -- vim-json
        --         vim.g.vim_json_syntax_conceal = false

        --         -- vim-markdown
        --         vim.g.vim_markdown_folding_disabled = 1
        --         vim.g.vim_markdown_conceal = 0
        --         vim.g.vim_markdown_follow_anchor = 1
        --         vim.g.vim_markdown_new_list_item_indent = 2
        --         vim.g.vim_markdown_no_default_key_mappings = 1
        --         vim.g.vim_markdown_strikethrough = 1

        --         -- vim-ruby
        --         vim.g.ruby_operators = 1
        --         vim.g.ruby_spellcheck_strings = 1
        --         vim.g.ruby_space_errors = 1

        --         vim.g.rubycomplete_buffer_loading = 1
        --         vim.g.rubycomplete_classes_in_global = 1
        --         vim.g.rubycomplete_load_gemfile = 1

        --         -- vim-yardoc
        --         -- vim.cmd("hi link yardGenericTag rubyInstanceVariable")
        --         -- vim.cmd("hi link yardTypeList rubyConstant")
        --         -- vim.cmd("hi link yardType rubyConstant")
        --     end
        -- }

        ------------------
        -- Elixir
        ------------------
        use({ "avdgaag/vim-phoenix", opt = true, ft = { "elixir", "eelixir" } })

        ------------------
        -- Git
        ------------------
        -- A Vim plugin for more pleasant editing on commit messages
        -- https://github.com/rhysd/committia.vim
        use({
            "rhysd/committia.vim",
            config = GetSetup("committia-vim"),
        })

        ------------------
        -- HTML
        ------------------
        -- emmet for vim
        use({ "mattn/emmet-vim", opt = true, ft = { "html", "html.*" } })

        ------------------
        -- just
        ------------------
        use({ "NoahTheDuke/vim-just" })

        use("LnL7/vim-nix")

        ------------------
        -- markdown
        ------------------
        use({ "plasticboy/vim-markdown", config = GetSetup("vim-markdown") })

        ------------------
        -- Ruby
        ------------------
        -- Ruby on Rails power tools
        use({ "tpope/vim-rails", ft = { "ruby", "eruby", "rspec" } })

        -- Its' like rails.vim without the rails
        use({
            "tpope/vim-rake",
            opt = true,
            ft = { "ruby", "eruby", "rspec" },
            requires = "tpope/vim-projectionist",
        })

        -- use '~/Development/projects/vim-rbs'
        use({ "turboladen/vim-rbs", ft = { "ruby", "rbs", "ruby.rbs", "rspec" } })

        -- https://github.com/rust-lang/rust.vim
        use({ "rust-lang/rust.vim", ft = "rust" })

        ------------------
        -- tmux
        ------------------
        -- Syntax, navigation, building
        use("tmux-plugins/vim-tmux")

        -- Restores `FocusGained` and `FocusLost` autocommand events work when using
        -- vim inside Tmux.
        use("tmux-plugins/vim-tmux-focus-events")

        ------------------
        -- YAML
        ------------------
        -- use {"stephpy/vim-yaml", ft = "yaml"}

        --===========================================================================
        -- 25. various
        --===========================================================================
        -- plenary: full; complete; entire; absolute; unqualified. All the lua
        -- functions I don't want to write twice.
        -- https://github.com/nvim-lua/plenary.nvim/
        use("nvim-lua/plenary.nvim")

        use({
            "jose-elias-alvarez/null-ls.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = GetSetup("null-ls-nvim"),
        })

        use({
            "mhartington/formatter.nvim",
            disable = true,
            ft = { "markdown", "lua" },
            cmd = "Format",
            config = GetSetup("formatter-nvim"),
        })

        use({
            "mfussenegger/nvim-dap",
            requires = "nvim-lua/plenary.nvim",
            config = GetSetup("nvim-dap"),
        })

        use({
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = GetSetup("nvim-dap-ui"),
        })

        use({
            "theHamsta/nvim-dap-virtual-text",
            requires = {
                "nvim-treesitter/nvim-treesitter",
                "mfussenegger/nvim-dap",
            },
            disable = disable_treesitter,
            config = GetSetup("nvim-dap-virtual-text"),
        })

        -- https://github.com/nvim-lua/lsp-status.nvim
        use({
            "neovim/nvim-lspconfig",
            requires = {
                "nvim-lua/lsp-status.nvim",
                "stevearc/aerial.nvim",
                "b0o/schemastore.nvim",
                "j-hui/fidget.nvim",
                "p00f/clangd_extensions.nvim",
            },
            config = GetSetup("nvim-lspconfig"),
        })

        use({
            "stevearc/aerial.nvim",
            config = GetSetup("aerial-nvim"),
        })

        use("folke/lsp-colors.nvim")

        -- Tools for better development in rust using neovim's builtin lsp
        -- https://github.com/simrat39/rust-tools.nvim
        use({
            "simrat39/rust-tools.nvim",
            requires = {
                "neovim/nvim-lspconfig",
                "nvim-lua/plenary.nvim",
                "mfussenegger/nvim-dap",
                "nvim-lua/lsp-status.nvim",
                -- "hood/popui.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
            },
            after = "nvim-lspconfig",
            config = GetSetup("rust-tools-nvim"),
        })

        -- use({
        --     "hood/popui.nvim",
        --     requires = {
        --         "RishabhRD/popfix",
        --     },
        --     config = GetSetup("popui-nvim"),
        -- })

        -- https://github.com/nvim-telescope/telescope.nvim
        -- https://github.com/nvim-telescope/telescope-github.nvim
        -- requires `gh` and don't forget to auth the first use!
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons",
                "nvim-treesitter/nvim-treesitter",
                "nvim-telescope/telescope-github.nvim",
                "nvim-telescope/telescope-symbols.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
            },
            -- cmd = "Telescope",
            config = GetSetup("telescope-nvim"),
        })

        -- https://github.com/folke/trouble.nvim
        use({
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = GetSetup("trouble-nvim"),
        })

        use({
            "sudormrfbin/cheatsheet.nvim",
            disable = true,
            cmd = { "Cheatsheet", "CheatsheetEdit" },
        })

        -- A small automated session manager for Neovim
        -- https://github.com/rmagatti/auto-session
        use({
            "rmagatti/auto-session",
            requires = "Asheq/close-buffers.vim",
            config = GetSetup("auto-session"),
        })
    end,
    config = {
        max_jobs = 20,
    },
})
