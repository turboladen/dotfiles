function GetSetup(name)
  return string.format('require("setup/%s")', name)
end

local disable_treesitter = false

return require("packer").startup({
  function(use)
    -- https://github.com/wbthomason/packer.nvim
    use({ "wbthomason/packer.nvim", config = GetSetup("packer") })
    use('lewis6991/impatient.nvim')

    use({
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    })
    use("williamboman/mason-lspconfig.nvim")

    -----------------------------------------------------------------------------
    -- 0.
    -----------------------------------------------------------------------------
    -- Enable repeating supported plugin maps with '.'
    -- https://github.com/tpope/vim-repeat
    use("tpope/vim-repeat")

    -- This plugin is a replacement for the included filetype.vim that is sourced on startup.
    -- https://github.com/nathom/filetype.nvim
    use({ "nathom/filetype.nvim" })

    -- use({ "jamestthompson3/nvim-remote-containers" })

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
        "andymass/vim-matchup"
      },
      config = GetSetup("nvim-treesitter"),
    })

    -- Lightweight alternative to context.vim implemented with nvim-treesitter.
    use({
      "romgrk/nvim-treesitter-context",
      -- disable = disable_treesitter,
      disable = true,
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
        -- nvim-cmp source for neovim builtin LSP client.
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/cmp-path",
        "nvim-lua/lsp-status.nvim",
        -- https://github.com/onsails/lspkind-nvim
        "onsails/lspkind-nvim",
        -- VSCode(LSP)'s snippet feature in vim.
        -- https://github.com/hrsh7th/vim-vsnip
        "hrsh7th/vim-vsnip",
        "rafamadriz/friendly-snippets",
        -- https://github.com/hrsh7th/cmp-buffer
        -- "hrsh7th/cmp-buffer",
        -- nvim-cmp source for neovim Lua API.
        -- https://github.com/hrsh7th/cmp-nvim-lua
        -- "hrsh7th/cmp-nvim-lua",
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

    use({
      "kdheepak/lazygit.nvim",
      config = GetSetup("lazygit-nvim"),
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

    -- Highlight and search for todo comments like TODO, HACK, BUG in your code base.
    -- https://github.com/folke/todo-comments.nvim
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup({})
      end,
    })

    -- Prismatic line decorations for the adventurous vim user
    -- https://github.com/mvllow/modes.nvim
    use({
      "mvllow/modes.nvim",
      config = function()
        vim.opt.cursorline = true
        require("modes").setup()
      end,
    })

    use({ "code-biscuits/nvim-biscuits", requires = "nvim-treesitter/nvim-treesitter", config = function()
      -- local icon = ""
      local icon = ""

      require("nvim-biscuits").setup({
        toggle_keybind = "<leader>cb",
        show_on_start = true,
        cursor_line_only = true,
        default_config = {
          max_distance = 25,
          prefix_string = " " .. icon .. " ",
        },
        -- language_config = {
        --   ruby = {
        --     prefix_string = " ✨ ",
        --     max_length = 80
        --   }
        -- }
      })
    end })

    use({
      "yamatsum/nvim-nonicons",
      requires = { "kyazdani42/nvim-web-devicons" }
    })

    -- Neovim plugin to improve the default vim.ui interfaces
    use('stevearc/dressing.nvim')

    -----------------------------------------------------------------------------
    -- 2. moving around, searching and patterns
    -----------------------------------------------------------------------------
    -- Use RipGrep in Vim and display results in a quickfix list
    use({ "jremmen/vim-ripgrep", command = "Rg", config = GetSetup("vim-ripgrep") })

    -- pairs of handy bracket mappings
    -- https://github.com/tpope/vim-unimpaired
    use("tpope/vim-unimpaired")

    -- Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
    use("Raimondi/delimitMate")

    -- match-up is a plugin that lets you highlight, navigate, and operate on sets
    -- of matching text. It extends vim's % key to language-specific words instead
    -- of just single characters.
    -- https://github.com/andymass/vim-matchup
    use({
      "andymass/vim-matchup",
      event = "VimEnter",
      config = GetSetup("vim-matchup"),
    })

    -- Directory viewer for Vim
    -- https://github.com/justinmk/vim-dirvish
    use("justinmk/vim-dirvish")

    -- Show git status of each file
    use({ "kristijanhusak/vim-dirvish-git", requires = "justinmk/vim-dirvish" })

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
    -- https://github.com/rebelot/kanagawa.nvim
    use("rebelot/kanagawa.nvim")

    use({ "aonemd/kuroi.vim", disable = true })
    use({ "sainnhe/edge", disable = true, config = GetSetup("edge") })

    -- https://github.com/savq/melange
    use({ "savq/melange", disable = true })

    -- https://github.com/EdenEast/nightfox.nvim
    use({ "EdenEast/nightfox.nvim", disable = true, config = GetSetup("nightfox-nvim") })

    -- https://github.com/rakr/vim-one
    use({ "rakr/vim-one", config = GetSetup("vim-one") })

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
    -- use({
    --   "rstacruz/vim-closer",
    --   requires = "tpope/vim-endwise",
    --   ft = { "sh", "zsh", "bash", "c", "cpp", "cmake", "html", "markdown", "vim", "ruby"}
    -- })
    use({ "steelsojka/pears.nvim" })

    -- https://github.com/tpope/vim-endwise
    use({ "tpope/vim-endwise" })

    -- https://github.com/numToStr/Comment.nvim
    use({
      "numToStr/Comment.nvim",
      config = GetSetup("Comment-nvim"),
    })

    -- A better annotation generator.
    -- https://github.com/danymat/neogen
    use({
      "danymat/neogen",
      config = function()
        require("neogen").setup({})
      end,
      requires = "nvim-treesitter/nvim-treesitter"
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

    use({
      "voldikss/vim-floaterm",
      config = function()
        -- vim.keymap.set("n", "<leader>ff",
        --   "<cmd>FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR>")

        vim.keymap.set("n", "t", "<cmd>FloatermToggle myfloat<CR>")
        vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:q<CR>")
      end
    })

    --===========================================================================
    -- 22. running make and jumping to errors (quickfix)
    --===========================================================================
    use({
      "klen/nvim-test",
      config = function()
        require('nvim-test').setup({})
      end
    })

    --===========================================================================
    -- 23. language specific
    --===========================================================================
    use({ "ekalinin/Dockerfile.vim" })

    ------------------
    -- Git
    ------------------
    -- A Vim plugin for more pleasant editing on commit messages
    -- https://github.com/rhysd/committia.vim
    use({
      "rhysd/committia.vim",
      config = GetSetup("committia-vim"),
    })

    use({
      "Joorem/vim-haproxy", opt = true, ft = { "haproxy" }
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

    ------------------
    -- markdown
    ------------------
    use({ "plasticboy/vim-markdown", config = GetSetup("vim-markdown") })

    ------------------
    -- Ruby
    ------------------
    use({ "vim-ruby/vim-ruby", ft = { "ruby", "eruby", "rspec" } })

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
    -- Rust
    ------------------
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
    use({ "stephpy/vim-yaml", ft = "yaml" })

    --===========================================================================
    -- 25. various
    --===========================================================================
    -- plenary: full; complete; entire; absolute; unqualified. All the lua
    -- functions I don't want to write twice.
    -- https://github.com/nvim-lua/plenary.nvim/
    use("nvim-lua/plenary.nvim")

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
      },
      after = "nvim-lspconfig",
      config = GetSetup("rust-tools-nvim"),
    })

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
      "olimorris/persisted.nvim",
      config = GetSetup("persisted-nvim")
    })
  end,
  config = {
    max_jobs = 20,
  },
})
