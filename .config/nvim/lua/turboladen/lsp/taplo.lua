local function setup(lspconfig, base_capabilities)
  -- cargo install taplo-cli
  lspconfig.taplo.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
