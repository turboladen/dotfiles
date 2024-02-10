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

  -- ╭────────────╮
  -- │ Wisely add │
  -- ╰────────────╯
  {
    "tpope/vim-endwise",
    event = "VeryLazy",
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
    enabled = false,
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
