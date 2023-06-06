local cmp = require("cmp")
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup({
  completion = {
    keyword_length = 1,
  },
  formatting = {
    format = require("lspkind").cmp_format(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --   ['<Down>'] = {
    --     i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    --   },
    --   -- ["<C-j>"] = cmp.mapping(
    --   --   function(fallback)
    --   --     cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    --   --   end,
    --   --   { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    --   -- ),
    --   ["<C-k>"] = cmp.mapping(
    --   -- function(fallback)
    --   --   cmp_ultisnips_mappings.jump_backwards(fallback)
    --   -- end,
    --     { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    --   ),
    -- mapping = {
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<C-j>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<C-k>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ['<CR>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
      end
    end
    -- },
  }),
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
    { name = 'cmdline' }
  })
})
