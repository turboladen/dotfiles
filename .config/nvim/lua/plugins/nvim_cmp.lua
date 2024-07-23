--  ╭──────────────────────────────────────────────────────╮
--  │ A completion engine plugin for neovim written in Lua │
--  ╰──────────────────────────────────────────────────────╯

local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.version = false
Plugin.enabled = true

Plugin.dependencies = {
  require("plugins.nvim_lspconfig"),

  -- Sources
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  require("plugins.nvim_cmp.cmp_cmdline"),
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-path",
  "lukas-reineke/cmp-rg",
  require("plugins.crates_nvim"),
  -- /Sources

  -- Snippets
  require("plugins.nvim_snippy"),
  'dcampos/cmp-snippy',
  -- /Snippets

  require("plugins.lspkind_nvim"),
}

Plugin.opts = function()
  local snippy = require("snippy")
  local cmp = require("cmp")
  local cmp_utils = require("plugins.nvim_cmp.utils")

  return {
    completion = {
      keyword_length = 1,
    },
    formatting = {
      format = require("lspkind").cmp_format({
        mode = "symbol_text",
        max_width = 50,
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

  require("plugins.nvim_cmp.cmp_cmdline").cmp_config(cmp)
end

return Plugin
