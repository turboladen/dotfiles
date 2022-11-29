local function GetSetup(name)
  return string.format('require("setup/%s")', name)
end

local disable_treesitter = false

return require("packer").startup({
  function(use)
    use({
      "wbthomason/packer.nvim",
      config = GetSetup("packer"),
    })
    -- Improve startup time for Neovim
    use('lewis6991/impatient.nvim')

    -- ⏲️ A Vim plugin for profiling Vim's startup time.
    use('dstein64/vim-startuptime')

    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    use({
      "williamboman/mason.nvim",
      requires = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
      },
      config = GetSetup("mason-nvim")
    })

    -----------------------------------------------------------------------------
    -- 0.
    -----------------------------------------------------------------------------
    -- Enable repeating supported plugin maps with '.'
    use("tpope/vim-repeat")

    -- This plugin is a replacement for the included filetype.vim that is sourced on startup.
    -- https://github.com/nathom/filetype.nvim
    use({ "nathom/filetype.nvim" })

    -- Open the current word with custom openers, GitHub shorthands for example.
    use({
      'ofirgall/open.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = GetSetup("open-nvim")
    })

    ------------------------------------------------------------------------------
    -- UI tweaks
    ------------------------------------------------------------------------------
    -- Treesitter configurations and abstraction layer for Neovim.
    --
    -- nvim-ts-rainbow: 🌈 Rainbow parentheses for neovim using tree-sitter 🌈
    -- nvim-ts-context-commentstring: Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
    -- nvim-treesitter-context: Show code context
    -- commentary.vim: comment stuff out
    --
    use({
      "nvim-treesitter/nvim-treesitter",
      disable = disable_treesitter,
      run = ":TSUpdate",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "tpope/vim-commentary", -- <- for ^^
        "andymass/vim-matchup",
        "nvim-treesitter/nvim-treesitter-context",
        "p00f/nvim-ts-rainbow",
      },
      config = GetSetup("nvim-treesitter"),
    })

    -- Lightweight alternative to context.vim implemented with nvim-treesitter.
    use({
      "nvim-treesitter/nvim-treesitter-context",
      disable = disable_treesitter,
      requires = { "nvim-treesitter/nvim-treesitter" },
      config = GetSetup("nvim-treesitter-context"),
    })

    -- Enhanced terminal integration for Vim.
    use("wincent/terminus")

    -- A completion plugin for neovim coded in Lua.
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "SirVer/ultisnips",
        "honza/vim-snippets",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "lukas-reineke/cmp-rg",
        "neovim/nvim-lspconfig",
        "nvim-lua/lsp-status.nvim",
        "nvim-treesitter/nvim-treesitter",
        "onsails/lspkind-nvim",
        "quangnguyen30192/cmp-nvim-ultisnips",
        "saecki/crates.nvim",
      },
      config = GetSetup("nvim-cmp"),
    })

    -- Use dependency and run lua function after load
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = GetSetup("gitsigns-nvim"),
    })

    -- Plugin for calling lazygit from within neovim.
    use({ "kdheepak/lazygit.nvim" })

    -- Distraction-free writing in Vim.
    use({
      "junegunn/goyo.vim",
      config = GetSetup("goyo-vim"),
      cmd = "Goyo",
    })

    -- A good looking and efficient status line.
    use({
      "datwaft/bubbly.nvim",
      requires = "nvim-lua/lsp-status.nvim",
      config = GetSetup("bubbly-nvim"),
    })

    -- A neovim plugin that helps managing crates.io dependencies
    use({
      "saecki/crates.nvim",
      tag = "v0.3.0",
      requires = { "nvim-lua/plenary.nvim" },
      event = { "BufRead Cargo.toml" },
      config = GetSetup("crates-nvim"),
    })

    -- ✍️ All the npm/yarn commands I don't want to type
    use({
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = GetSetup("package-info-nvim")
    })

    -- Highlight and search for todo comments like TODO, HACK, BUG in your code base.
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = GetSetup("todo-comments-nvim")
    })

    -- Prismatic line decorations for the adventurous vim user
    use({
      "mvllow/modes.nvim",
      config = GetSetup("modes-nvim")
    })

    -- A neovim port of Assorted Biscuits.
    use({
      "code-biscuits/nvim-biscuits",
      requires = "nvim-treesitter/nvim-treesitter",
      config = GetSetup("nvim-biscuits")
    })

    use({
      "yamatsum/nvim-nonicons",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = GetSetup("nvim-nonicons")
    })

    -- Neovim plugin to improve the default vim.ui interfaces
    use('stevearc/dressing.nvim')

    -----------------------------------------------------------------------------
    -- 2. moving around, searching and patterns
    -----------------------------------------------------------------------------
    -- Use RipGrep in Vim and display results in a quickfix list
    use({
      "jremmen/vim-ripgrep",
      command = "Rg",
      config = GetSetup("vim-ripgrep")
    })

    -- pairs of handy bracket mappings
    use("tpope/vim-unimpaired")

    -- Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
    use("Raimondi/delimitMate")

    -- match-up is a plugin that lets you highlight, navigate, and operate on sets
    -- of matching text. It extends vim's % key to language-specific words instead
    -- of just single characters.
    use({
      "andymass/vim-matchup",
      config = GetSetup("vim-matchup"),
    })

    -- Directory viewer for Vim
    use("justinmk/vim-dirvish")

    -- Show git status of each file
    use({ "kristijanhusak/vim-dirvish-git", requires = "justinmk/vim-dirvish" })

    -- Change code right in the quickfix window
    use("stefandtw/quickfix-reflector.vim")

    -- Hlsearch Lens for Neovim
    use({
      "kevinhwang91/nvim-hlslens",
      config = GetSetup("nvim-hlslens")
    })

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
    local disable_extra_themes = false

    -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
    use({
      "rebelot/kanagawa.nvim",
      disable = disable_extra_themes
    })

    use({
      "aonemd/kuroi.vim",
      disable = disable_extra_themes,
    })

    use({
      "EdenEast/nightfox.nvim",
      disable = disable_extra_themes,
      config = GetSetup("nightfox-nvim"),
    })

    use({
      "navarasu/onedark.nvim",
      disable = disable_extra_themes,
      config = GetSetup("onedark-nvim")
    })

    -- NOTE: To enable this, edit the setup file.
    use({
      "sainnhe/everforest",
      disable = disable_extra_themes,
      config = GetSetup("everforest"),
    })

    -- NOTE: To enable this, edit the setup file.
    use({
      "marko-cerovac/material.nvim",
      config = GetSetup("material-nvim"),
    })

    -- Hyperfocus-writing in Vim
    use({
      "junegunn/limelight.vim",
      cmd = "Limelight",
      config = GetSetup("limelight-vim"),
    })

    -- Show vertical line for indentation level
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = GetSetup("indent-blankline-nvim"),
    })

    --===========================================================================
    -- 6. multiple windows
    --===========================================================================
    -- Delete all the buffers except the current/named buffer
    use({
      "vim-scripts/BufOnly.vim",
      cmd = "BufOnly",
    })

    --===========================================================================
    -- 13. editing text
    --===========================================================================
    -- Closes brackets. Perfect companion to vim-endwise. Basically, a more
    -- conservative version of auto-pairs that only works when you press Enter.
    -- use({
    --   "rstacruz/vim-closer",
    --   requires = "tpope/vim-endwise",
    --   ft = { "sh", "zsh", "bash", "c", "cpp", "cmake", "html", "markdown", "vim", "ruby"}
    -- })

    -- Auto close parentheses and repeat by dot dot dot...
    use("cohama/lexima.vim")

    -- Wisely add
    use("tpope/vim-endwise")

    -- 🧠 💪 // Smart and powerful comment plugin for neovim.
    use({
      "numToStr/Comment.nvim",
      config = GetSetup("Comment-nvim"),
    })

    -- A better annotation generator.
    use({
      "danymat/neogen",
      requires = "nvim-treesitter/nvim-treesitter",
      config = GetSetup("neogen"),
    })

    -- quoting/parenthesizing made simple
    use("tpope/vim-surround")

    -- Adds gS and gJ to split/join code blocks.
    use("AndrewRadev/splitjoin.vim")

    use({
      'Wansmer/treesj',
      requires = { 'nvim-treesitter' },
      config = GetSetup("treesj")
    })

    -- Easy text exchange operator
    use("tommcdo/vim-exchange")

    -- Protect against weird unicode copy/paste
    use({
      "vim-utils/vim-troll-stopper",
      config = GetSetup("vim-troll-stopper"),
    })

    -- For case swapping
    use({
      "idanarye/vim-casetrate",
      cmd = "Casetrate",
    })

    -- Vim script for text filtering and alignment
    use({
      "godlygeek/tabular",
      cmd = "Tabularize",
    })

    --===========================================================================
    -- 21. executing external commands
    --===========================================================================
    -- Asynchronous build and test dispatcher. Used for running specs in a separate tmux pane.
    use({
      "tpope/vim-dispatch",
      config = GetSetup("vim-dispatch"),
      cmd = {
        "AbortDispatch",
        "Copen",
        "Copen!",
        "Dispatch",
        "Dispatch!",
        "FocusDispatch",
        "FocusDispatch!",
        "Make",
        "Make!",
        "Spawn",
        "Spawn!",
        "Start",
        "Start!",
      },
    })

    -- Vim sugar for the UNIX shell commands that need it the most
    use({
      "tpope/vim-eunuch",
      cmd = {
        "Chmod",
        "Delete",
        "Delete!",
        "Mkdir",
        "Move",
        "Remove",
        "Remove!",
        "Rename",
        "Unlink",
      },
    })

    -- 🌟 Terminal manager for (neo)vim
    use({
      "voldikss/vim-floaterm",
      config = GetSetup("vim-floaterm")
    })

    --===========================================================================
    -- 22. running make and jumping to errors (quickfix)
    --===========================================================================
    use({
      "nvim-neotest/neotest",
      requires = {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "olimorris/neotest-rspec",
        "rouge8/neotest-rust"
      },
      config = GetSetup("neotest")
    })

    --===========================================================================
    -- 23. language specific
    --===========================================================================
    use({
      "sheerun/vim-polyglot",
      config = GetSetup("vim-markdown")
    })

    use({ "ekalinin/Dockerfile.vim" })

    ------------------
    -- Git
    ------------------
    -- A Vim plugin for more pleasant editing on commit messages
    use({
      "rhysd/committia.vim",
      config = GetSetup("committia-vim"),
    })

    ------------------
    -- HTML
    ------------------
    -- emmet for vim
    use({ "mattn/emmet-vim", opt = true, ft = { "html" } })

    ------------------
    -- markdown
    ------------------
    -- use({ "plasticboy/vim-markdown", config = GetSetup("vim-markdown") })
    use({
      'toppair/peek.nvim',
      run = 'deno task --quiet build:fast',
      config = function()
        require("peek").setup({})
        vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
        vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
      end
    })

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

    ------------------
    -- tmux
    ------------------
    -- Restores `FocusGained` and `FocusLost` autocommand events work when using
    -- vim inside Tmux.
    use("tmux-plugins/vim-tmux-focus-events")

    ------------------
    -- YAML
    ------------------
    use({ "stephpy/vim-yaml", ft = "yaml" })

    --===========================================================================
    -- 25. various
    --===========================================================================
    -- Debug Adapter Protocol client implementation for Neovim
    use({
      "mfussenegger/nvim-dap",
      requires = "nvim-lua/plenary.nvim",
      config = GetSetup("nvim-dap"),
    })

    -- A UI for nvim-dap
    use({
      "rcarriga/nvim-dap-ui",
      requires = "mfussenegger/nvim-dap",
      config = GetSetup("nvim-dap-ui"),
    })

    -- This plugin adds virtual text support to nvim-dap.
    use({
      "theHamsta/nvim-dap-virtual-text",
      requires = {
        "nvim-treesitter/nvim-treesitter",
        "mfussenegger/nvim-dap",
      },
      disable = disable_treesitter,
      config = GetSetup("nvim-dap-virtual-text"),
    })

    -- Quickstart configs for Nvim LSP
    use({
      "neovim/nvim-lspconfig",
      requires = {
        "b0o/schemastore.nvim",
        "j-hui/fidget.nvim",
        "nvim-lua/lsp-status.nvim",
        "p00f/clangd_extensions.nvim",
        "stevearc/aerial.nvim",
      },
      config = GetSetup("nvim-lspconfig"),
    })

    -- Neovim plugin for a code outline window
    use({
      "stevearc/aerial.nvim",
      config = GetSetup("aerial-nvim"),
    })

    -- 🌈 Plugin that creates missing LSP diagnostics highlight groups for color
    -- schemes that don't yet support the Neovim 0.5 builtin LSP client.
    use({
      "folke/lsp-colors.nvim",
      config = GetSetup("lsp-colors-nvim")
    })

    -- Tools for better development in rust using neovim's builtin lsp
    use({
      "simrat39/rust-tools.nvim",
      requires = {
        "mfussenegger/nvim-dap",
        "neovim/nvim-lspconfig",
        "nvim-lua/lsp-status.nvim",
        "nvim-lua/plenary.nvim",
      },
      after = "nvim-lspconfig",
      config = GetSetup("rust-tools-nvim"),
    })

    -- Find, Filter, Preview, Pick. All lua, all the time.
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-treesitter/nvim-treesitter",
        "otavioschwanck/telescope-alternate",
      },
      -- cmd = "Telescope",
      config = GetSetup("telescope-nvim"),
    })

    -- Alternate between common files using pre-defined regexp. Just map the
    -- patterns and starting navigating between files that are related.
    use({
      "otavioschwanck/telescope-alternate",
      config = GetSetup("telescope-alternate")
    })

    -- 🚦 A pretty diagnostics, references, telescope results, quickfix and
    -- location list to help you solve all the trouble your code is causing.
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = GetSetup("trouble-nvim"),
    })
  end,
  config = {
    max_jobs = 20
  }
})
