local function setup(lspconfig, base_capabilities)
  -- npm install -g dockerfile-language-server-nodejs
  -- https://github.com/rcjsuen/dockerfile-language-server-nodejs
  lspconfig.dockerls.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })

end

return {
  setup = setup
}
