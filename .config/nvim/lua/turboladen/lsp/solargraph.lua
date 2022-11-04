local function setup(lspconfig, base_capabilities)
  lspconfig.solargraph.setup({
    init_options = {
      documentFormatting = true
    },
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
end

return {
  setup = setup
}
