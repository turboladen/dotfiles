--  ╭──────────────────────────────────────────────────────╮
--  │ A completion engine plugin for neovim written in Lua │
--  ╰──────────────────────────────────────────────────────╯

local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.version = false
Plugin.event = "VeryLazy"
Plugin.enabled = true

Plugin.dependencies = {
  require("plugins.nvim_lspconfig"),

  -- Sources
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-path",
  "lukas-reineke/cmp-rg",
  require("plugins.crates_nvim"),
  -- /Sources

  -- Snippets
  --  ╭──────────────────────────────────────────╮
  --  │ Snippet plugin for Neovim written in Lua │
  --  ╰──────────────────────────────────────────╯
  {
    "dcampos/nvim-snippy",
    event = "VeryLazy",
    lazy = true,
    dependencies = { "honza/vim-snippets" },
    opts = {
      mappings = {
        is = {
          ['<Tab>'] = 'expand_or_advance',
          ['<S-Tab>'] = 'previous',
        },
        nx = {
          ['<leader>x'] = 'cut_text',
        },
      },
    },
    -- keys = function()
    --   local mappings = require('snippy.mapping')
    --
    --   -- TODO: Haven't yet confirmed these do what I want.
    --   return {
    --     { "<Tab>",   mappings.expand_or_advance("<Tab>"), "i" },
    --
    --     { "<Tab>",   mappings.next("<Tab>"),              "s" },
    --     { "<C-j>",   mappings.next("<Tab>"),              "s" },
    --     { "<S-Tab>", mappings.previous("<S-Tab>"),        { "i", "s" } },
    --     { "<C-j>",   mappings.previous("<C-j>"),          { "i", "s" } },
    --     { "<Tab>",   mappings.cut_text,                   "x",         { remap = true } },
    --     { "g<Tab>",  mappings.cut_text,                   "n",         { remap = true } },
    --   }
    -- end
  },
  'dcampos/cmp-snippy',
  -- /Snippets

  -- "nvim-treesitter/nvim-treesitter",
  "onsails/lspkind-nvim",
}

Plugin.opts = function()
  -- local has_words_before = function()
  --   unpack = unpack or table.unpack
  --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  -- end

  local snippy = require("snippy")
  local cmp = require("cmp")
  local cmp_utils = require("plugins.cmp.utils")

  return {
    completion = {
      keyword_length = 1,
    },
    formatting = {
      format = require("lspkind").cmp_format({
        mode = "symbol_text",
        max_width = 50,
        symbol_map = { Copilot = "" }
      }),
    },
    mapping = {
      ["<C-j>"] = cmp_utils.select_next(cmp, snippy),
      ["<Tab>"] = cmp_utils.select_next(cmp, snippy),
      ["<C-k>"] = cmp_utils.select_prev(cmp, snippy),
      ["<S-Tab>"] = cmp_utils.select_prev(cmp, snippy),
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
      { name = "copilot" },
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    }
  }
end

Plugin.config = function(_, opts)
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

return Plugin
