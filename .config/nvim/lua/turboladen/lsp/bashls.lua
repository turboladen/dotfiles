-- https://github.com/bash-lsp/bash-language-server
local function setup(lspconfig, base_capabilities)
  lspconfig.bashls.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
end

return {
  setup = setup
}
