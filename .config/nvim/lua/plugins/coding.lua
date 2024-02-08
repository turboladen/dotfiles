return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    -- event = "VeryLazy",
    opts = {
      suggestion = {
        auto_trigger = true,
        debounce = 300,
      },
      filetypes = {
        markdown = true,
        gitcommit = true,
        gitrebase = true,
      }
    },
    config = function(opts)
      require("copilot").setup(opts)
    end
  },

  -- { "github/copilot.vim" },

  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require("mini.basics").setup()
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })
      -- require("mini.pairs").setup()
      -- require("mini.sessions").setup({
      --   autoread = true
      -- })

      -- require("mini.completion").setup()
      -- vim.keymap.set('i', '<C-j>', [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { expr = true })
      -- vim.keymap.set('i', '<C-k>', [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true })
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "notify",
          "ruby",
          "rust",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
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

  -- ╭────────────────────────────────╮
  -- │ A better annotation generator. │
  -- ╰────────────────────────────────╯
  {
    "danymat/neogen",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    config = function(_, opts)
      local neogen = require("neogen")
      neogen.setup(opts)
    end,
    keys = function()
      local neogen = require("neogen")

      return {
        { "<leader>cg", neogen.generate,  desc = "Generate annotation" },
        { "<Tab>",      neogen.jump_next, desc = "Next annotation" },
        { "<S-Tab>",    neogen.jump_prev, desc = "Next annotation" },
      }
    end
  },

  -- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  -- ┃         💻 Neovim setup for init.lua and plugin          ┃
  -- ┃      development with full signature help, docs and      ┃
  -- ┃             completion for the nvim lua API.             ┃
  -- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  {
    "folke/neodev.nvim",
    event = "VeryLazy",
    opts = {
      library = {
        plugins = { "neotest" },
        types = true
      },
    },
  },

  --  ╭──────────────────────────────────────────────────────────────────────────────╮
  --  │ A tree like view for symbols in Neovim using the Language Server             │
  --  │  Protocol. Supports all your favourite languages.                            │
  --  ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    "simrat39/symbols-outline.nvim",
    enabled = false,
    event = "VeryLazy",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    opts = {},
    keys = {
      { "<leader>aa", "<cmd>SymbolsOutline<cr>", desc = "Toggle symbols" }
    }
  },

  -- ╭──────────────────────────────────────────────────╮
  -- │ ✍️ All the npm/yarn commands I don't want to type │
  -- ╰──────────────────────────────────────────────────╯
  {
    "vuki656/package-info.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      local package_info = require('package-info')
      package_info.setup()

      -- vim.keymap.set({ "n" }, "<LEADER>ns", package_info.show, { desc = "Show dependency versions" })
      -- vim.keymap.set({ "n" }, "<LEADER>nc", package_info.hide, { desc = "Hide dependency versions" })
      -- vim.keymap.set({ "n" }, "<LEADER>nu", package_info.update, { desc = "Update dependency on the line" })
      -- vim.keymap.set({ "n" }, "<LEADER>nd", package_info.delete, { desc = "Delete dependency on the line" })
      -- vim.keymap.set({ "n" }, "<LEADER>ni", package_info.install, { desc = "Install a new dependency" })
      -- vim.keymap.set({ "n" }, "<LEADER>np", package_info.change_version,
      --   { desc = "Install a different dependency version" })
    end
  },

}
