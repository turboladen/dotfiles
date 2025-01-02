local snippy = require("snippy")
local cmp = require("cmp")

local select_next = function(cmp, snippy)
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

local select_prev = function(cmp, snippy)
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

cmp.setup({
  snippet = {
    expand = function(args)
      require('snippy').expand_snippet(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
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

  {
    keyword_length = 1,
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol_text",
      max_width = 50,
    }),
  },
})

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
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      },
    }
  })
})
