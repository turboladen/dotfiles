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

  -- ╭───────────────────────────────────────────╮
  -- │ Adds gS and gJ to split/join code blocks. │
  -- ╰───────────────────────────────────────────╯
  {
    "AndrewRadev/splitjoin.vim",
    event = "VeryLazy",
  },

  -- ╭────────────────────────────────────────────────────╮
  -- │ Neovim plugin for splitting/joining blocks of code │
  -- ╰────────────────────────────────────────────────────╯
  {
    'Wansmer/treesj',
    event = "VeryLazy",
    dependencies = { 'nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
    },
    config = function(_, opts)
      require('treesj').setup(opts)

      -- Fallback to splitjoin on unsupported language: https://github.com/Wansmer/treesj/discussions/19
      local langs = require('treesj.langs')['presets']

      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = '*',
        callback = function()
          local map_opts = { buffer = true }

          if langs[vim.bo.filetype] then
            vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', map_opts)
            vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', map_opts)
          else
            vim.keymap.set('n', 'gS', '<Cmd>SplitjoinSplit<CR>', map_opts)
            vim.keymap.set('n', 'gJ', '<Cmd>SplitjoinJoin<CR>', map_opts)
          end
        end,
      })
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

  --  ╭──────────────────────────────────────────────────────────╮
  --  │    ✨ Clarify and beautify your comments using boxes     │
  --  │                        and lines.                        │
  --  ╰──────────────────────────────────────────────────────────╯

  "LudoPinelli/comment-box.nvim",
  lazy = true,
  cmd = {
    --  ╭──────────────────────────────────────────────────────────╮
    --  │ Left aligned boxes                                       │
    --  ╰──────────────────────────────────────────────────────────╯
    "CBllbox", -- Left-aligned box of fixed size with Left-aligned text
    "CBlcbox", -- Left-aligned box of fixed size with centered text
    "CBlrbox", -- Left-aligned box of fixed size with Right-aligned text

    --         ╭──────────────────────────────────────────────────────────╮
    --         │ Centered boxes                                           │
    --         ╰──────────────────────────────────────────────────────────╯
    "CBclbox", -- Centered box of fixed size with Left-aligned text
    "CBccbox", -- Centered box of fixed size with centered text
    "CBcrbox", -- Centered box of fixed size with Right-aligned text

    --                  ╭──────────────────────────────────────────────────────────╮
    --                  │ Right aligned boxes                                      │
    --                  ╰──────────────────────────────────────────────────────────╯
    "CBrlbox", -- Right-aligned box of fixed size with Left-aligned text
    "CBrcbox", -- Right-aligned box of fixed size with centered text
    "CBrrbox", -- Right-aligned box of fixed size with Right-aligned text

    --  ╭───────────────╮
    --  │ Adapted boxes │
    --  ╰───────────────╯
    "CBalbox", -- Left-aligned adapted box
    "CBacbox", -- Centered adapted box
    "CBarbox", -- Right-aligned adapted box

    --  ────────────────────────────────────────────────────────────
    --    Line things
    --  ├──────────────────────────────────────────────────────────┤
    "CBline",  -- Left-aligned line
    "CBcline", -- Centered line
    "CBrline", -- Right-aligned line

    -- Show the catalog
    "CBcatalog"
  },

  -- ╭──────────────────────────────────────────────────────────╮
  -- │    A file manager for Neovim which lets you edit your    │
  -- │              filesystem like you edit text               │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "elihunter173/dirbuf.nvim",
    event = "VeryLazy"
  },

  --  ╭────────────────────────────────────╮
  --  │ 💥 Create key bindings that stick. │
  --  ╰────────────────────────────────────╯
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- init = function()
    --   vim.o.timeout = true
    --   vim.o.timeoutlen = 300
    -- end,
    opts = {
      plugins = {
        -- spelling = true,
        presets = {
          windows = false,
          nav = false
        }
      },
      defaults = {
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>t"] = { name = "+test" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      }
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end
  },

  -- ╭──────────────────────────────────────────────────────────────────────╮
  -- │ 🚦 A pretty diagnostics, references, telescope results, quickfix and │
  -- │ location list to help you solve all the trouble your code is causing.│
  -- ╰──────────────────────────────────────────────────────────────────────╯
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleRefresh", "TroubleToggle" },
    opts = {
      -- auto_preview = false,
      auto_close = true,
      use_diagnostic_signs = true
    },
    config = function(_, opts)
      require("trouble").setup(opts)
    end,
  },

  -- ╭─────────────────────────────────────────╮
  -- │ Neovim plugin for a code outline window │
  -- ╰─────────────────────────────────────────╯
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    -- enabled = false,
    lazy = true,
    opts = {
      filter_kind = false,
      on_attach = function(bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Aerial does not set any mappings by default, so you'll want to set some up
        -- Toggle the aerial window with <leader>a
        vim.keymap.set("n", "<leader>aa", require("aerial").toggle, opts)

        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", require("aerial").prev, opts)
        vim.keymap.set("n", "}", require("aerial").next, opts)

        -- Jump up the tree with '[[' or ']]'
        vim.keymap.set("n", "[[", require('aerial').prev_up, opts)
        vim.keymap.set("n", "]]", require('aerial').next_up, opts)
      end
    },
    config = function(_, opts)
      local telescope = require("telescope")
      require("aerial").setup(opts)
      telescope.load_extension('aerial')
    end
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
