local function select_next(cmp, snippy)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif snippy.can_expand_or_advance() then
      snippy.expand_or_advance()
    else
      fallback()
    end
  end, { "i", "s", "c" })
end

local function select_prev(cmp, snippy)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif snippy.can_jump(-1) then
      snippy.previous()
    else
      fallback()
    end
  end, { "i", "s", "c" })
end

return {
  {
    "dcampos/nvim-snippy",
    dependencies = { "honza/vim-snippets" },
    lazy = true,
    opts = {},
  },

  --  ╭────────────────────────────────────────────────────────────╮
  --  │ A neovim plugin that helps managing crates.io dependencies │
  --  ╰────────────────────────────────────────────────────────────╯
  {
    "saecki/crates.nvim",
    -- version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    init = function()
      local crates_group = vim.api.nvim_create_augroup("crates", {})

      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = "toml",
        group = crates_group,
        command = "nnoremap <silent> K :lua require('crates').show_popup()<CR>"
      })
    end,
    opts = {},
    config = function()
      local crates = require("crates")
      crates.setup()

      vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Enable/disable crate info" })
      vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload (clear cache)" })
      vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show crate details w/version info" })
      vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show crate details w/feature info" })
    end,
  },

  --  ╭──────────────────────────────────────────────────────╮
  --  │ A completion engine plugin for neovim written in Lua │
  --  ╰──────────────────────────────────────────────────────╯
  {
    "hrsh7th/nvim-cmp",
    version = false,
    -- event = "InsertEnter",
    dependencies = {
      -- "neovim/nvim-lspconfig",

      -- Sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-rg",
      "saecki/crates.nvim",
      -- /Sources

      -- Snippets
      'dcampos/nvim-snippy',
      'dcampos/cmp-snippy',
      -- /Snippets

      -- "nvim-lua/lsp-status.nvim",
      -- "nvim-treesitter/nvim-treesitter",
      "onsails/lspkind-nvim",
    },
    opts = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local snippy = require("snippy")
      local cmp = require("cmp")

      return {
        completion = {
          keyword_length = 1,
        },
        formatting = {
          format = require("lspkind").cmp_format(),
        },
        mapping = {
          ["<C-j>"] = select_next(cmp, snippy),
          ["<Tab>"] = select_next(cmp, snippy),
          ["<C-k>"] = select_prev(cmp, snippy),
          ["<S-Tab>"] = select_prev(cmp, snippy),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            c = cmp.mapping.confirm()
          }),
        },

        snippet = {
          expand = function(args)
            require('snippy').expand_snippet(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "crates" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "rg" },
          { name = "snippy" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        }
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
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

  -- ╭─────────────────────────────────╮
  -- │ pairs of handy bracket mappings │
  -- ╰─────────────────────────────────╯
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
  },

  -- ╭─────────────────────────────────────────────────────╮
  -- │ Auto close parentheses and repeat by dot dot dot... │
  -- ╰─────────────────────────────────────────────────────╯
  {
    "cohama/lexima.vim",
    event = "VeryLazy",
  },

  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy"
  -- }

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
    lazy = true,
    cmd = "Casetrate",
  },

  -- ╭─────────────────────────────────────────────╮
  -- │ Vim script for text filtering and alignment │
  -- ╰─────────────────────────────────────────────╯
  {
    "godlygeek/tabular",
    lazy = true,
    cmd = "Tabularize",
  },

  -- ╭──────────────────────────────────────────╮
  -- │ Protect against weird unicode copy/paste │
  -- ╰──────────────────────────────────────────╯
  {
    "vim-utils/vim-troll-stopper",
    lazy = false,
    init = function()
      vim.cmd([[highlight TrollStopper ctermbg = red guibg = #FF0000 ]])
    end
  },

  -- ╭────────────────────────────────╮
  -- │ A better annotation generator. │
  -- ╰────────────────────────────────╯
  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    config = function(_, opts)
      local neogen = require("neogen")
      neogen.setup(opts)

      local map_opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<leader>ng", neogen.generate, map_opts)

      vim.keymap.set("i", "<C-l>", neogen.jump_next, map_opts)
      vim.keymap.set("i", "<C-h>", neogen.jump_prev, map_opts)
    end
  },
  -- ╭────────────────────────────────────────────────────────╮
  -- │ 🧠 💪 // Smart and powerful comment plugin for neovim. │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {}
  },

  --         ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  --         ┃         💻 Neovim setup for init.lua and plugin          ┃
  --         ┃      development with full signature help, docs and      ┃
  --         ┃             completion for the nvim lua API.             ┃
  --         ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  {
    "folke/neodev.nvim",
    opts = {
      library = {
        plugins = { "neotest" },
        types = true
      },
    },
  }
}
