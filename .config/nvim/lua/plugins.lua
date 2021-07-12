-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A collection of common configurations for Neovim's built-in language server client.
  use 'neovim/nvim-lspconfig'

  -- This is a very lightweight companion plugin for nvim-lspconfig. It adds the
  -- missing :LspInstall <language> command to conveniently install language servers.
  use {
    'kabouzeid/nvim-lspinstall',
    requires = { 'neovim/nvim-lspconfig' }
  }

  -- Repo to hold a bunch of info & extension callbacks for built-in LSP.
  use 'nvim-lua/lsp_extensions.nvim'

  -- This tiny plugin adds vscode-like pictograms to neovim built-in lsp
  use 'onsails/lspkind-nvim'

  -- Auto completion plugin for nvim.
  -- use {
  --   'hrsh7th/nvim-compe',
  --   requires = { 'neovim/nvim-lspconfig' }
  -- }
  use {
    'nvim-lua/completion-nvim',
    requires = { 'neovim/nvim-lspconfig' }
  }

  use {
    'steelsojka/completion-buffers',
    requires = { 'nvim-lua/completion-nvim' }
  }

  -- VSCode 💡 for neovim's built-in LSP.
  use {
    'kosayoda/nvim-lightbulb',
    requires = { 'neovim/nvim-lspconfig' }
  }

  -- [WIP] An implementation of the Popup API from vim in Neovim.
  use {
    'nvim-lua/popup.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function() require('telescope').setup() end
  }

  use {
    'simrat39/rust-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      { 'nvim-lua/popup.nvim', opt = true },
      { 'nvim-lua/plenary.nvim', opt = true },
      { 'nvim-telescope/telescope.nvim', opt = true },
    }
  }

  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  use {
    'hrsh7th/vim-vsnip-integ',
    requires = { 'hrsh7th/vim-vsnip' }
  }

  use "ray-x/lsp_signature.nvim"
  -- Simple plugins can be specified as strings
  -- use '9mm/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  -- use {
  --   'w0rp/ale',
  --   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --   cmd = 'ALEEnable',
  --   config = 'vim.cmd[[ALEEnable]]'
  -- }

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
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- You can specify multiple plugins in a single call
  -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }

  -- use {
  --   'beauwilliams/statusline.lua',
  --   requires = { 'nvim-lua/lsp-status.nvim' },
  --   config = function()
  --     local statusline = require('statusline')
  --   end
  -- }
end)
