return {
  {
    "turboladen/init.rs",
    dev = true,
    config = function()
      vim.o.completefunc = "v:lua.require'init_rs'.regex_buffer_completer"
    end
  },

  -- ╭─────────────────────────────╮
  -- │ Easy text exchange operator │
  -- ╰─────────────────────────────╯
  {
    "tommcdo/vim-exchange",
    event = "VeryLazy",
  },

  -- ╭────────────────────────────────────╮
  -- │ quoting/parenthesizing made simple │
  -- ╰────────────────────────────────────╯
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ Vim plugin, provides insert mode auto-completion for quotes,             │
  -- │ parens, brackets, etc.                                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "Raimondi/delimitMate",
    event = "VeryLazy",
  },

  -- ╭───────────────────────────────────────────────────────────────────────╮
  -- │ match-up is a plugin that lets you highlight, navigate, and operate   │
  -- │ on sets of matching text. It extends vim's % key to language-specific │
  -- │ words instead of just single characters.                              │
  -- ╰───────────────────────────────────────────────────────────────────────╯
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    init = function()
      vim.g.matchup_surround_enabled = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },

  -- ╭────────────╮
  -- │ Wisely add │
  -- ╰────────────╯
  {
    "tpope/vim-endwise",
    event = "VeryLazy",
  },

  -- ╭────────────────────────────────────────────────────╮
  -- │ Neovim plugin for splitting/joining blocks of code │
  -- ╰────────────────────────────────────────────────────╯
  {
    'Wansmer/treesj',
    event = "VeryLazy",
    dependencies = {
      'nvim-treesitter',
      -- ╭───────────────────────────────────────────╮
      -- │ Adds gS and gJ to split/join code blocks. │
      -- ╰───────────────────────────────────────────╯
      "AndrewRadev/splitjoin.vim",
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 100,
    },
    config = function(_, opts)
      require('treesj').setup(opts)
      require("user.commands").treesj()
    end
  },

  -- ╭───────────────────╮
  -- │ For case swapping │
  -- ╰───────────────────╯
  {
    "idanarye/vim-casetrate",
    event = "VeryLazy",
    cmd = "Casetrate",
  },

  -- ╭─────────────────────────────────────────────╮
  -- │ Vim script for text filtering and alignment │
  -- ╰─────────────────────────────────────────────╯
  {
    "godlygeek/tabular",
    event = "VeryLazy",
    cmd = "Tabularize",
  },

  -- ╭──────────────────────────────────────────╮
  -- │ Protect against weird unicode copy/paste │
  -- ╰──────────────────────────────────────────╯
  {
    "vim-utils/vim-troll-stopper",
    event = "VeryLazy",
    init = function()
      vim.cmd([[highlight TrollStopper ctermbg = red guibg = #FF0000 ]])
    end
  },

  -- ╭──────────────────────────────────────────────────────────╮
  -- │    A file manager for Neovim which lets you edit your    │
  -- │              filesystem like you edit text               │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "elihunter173/dirbuf.nvim",
    event = "VeryLazy"
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ Highlight and search for todo comments like TODO, HACK, BUG in your      │
  -- │ code base.                                                               │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ╭──────────────────────────╮
  -- │ Hlsearch Lens for Neovim │
  -- ╰──────────────────────────╯
  {
    "kevinhwang91/nvim-hlslens",
    opts = {}
  },

  -- ╭─────────────────────────────────────────────────────────────╮
  -- │ Vim sugar for the UNIX shell commands that need it the most │
  -- ╰─────────────────────────────────────────────────────────────╯
  {
    "tpope/vim-eunuch",
    cmd = {
      "Chmod",
      "Delete",
      "Mkdir",
      "Move",
      "Remove",
      "Rename",
      "Unlink",
    },
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ Asynchronous build and test dispatcher. Used for running specs in a      │
  -- │ separate tmux pane.                                                      │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "tpope/vim-dispatch",
    cmd = {
      "AbortDispatch",
      "Copen",
      "Dispatch",
      "FocusDispatch",
      "Make",
      "Spawn",
      "Start",
    },
    init = function()
      vim.g.dispatch_no_maps = 1
    end
  },

  -- ╭───────────────────────────────────────────────────────────╮
  -- │ Use RipGrep in Vim and display results in a quickfix list │
  -- ╰───────────────────────────────────────────────────────────╯
  {
    "jremmen/vim-ripgrep",
    cmd = "Rg",
    init = function()
      vim.g.rg_command = "rg --vimgrep --ignore-vcs"
      -- vim.g.rg_highlight = 1
    end
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Delete all the buffers except the current/named buffer │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "vim-scripts/BufOnly.vim",
    cmd = "BufOnly",
  },

  -- ╭────────────────────────────────────────╮
  -- │ Enhanced terminal integration for Vim. │
  -- ╰────────────────────────────────────────╯
  {
    "wincent/terminus",
    event = "VeryLazy"
  },

  -- ╭──────────────────────────────────────────╮
  -- │ Change code right in the quickfix window │
  -- ╰──────────────────────────────────────────╯
  {
    "stefandtw/quickfix-reflector.vim",
    event = "VeryLazy"
  },
}
