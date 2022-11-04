local function setup(lspconfig, base_capabilities)
  -- npm install -g vim-language-server
  -- https://github.com/iamcco/vim-language-server
  lspconfig.vimls.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
