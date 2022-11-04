--
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
-- https://github.com/theia-ide/typescript-language-server
--
local function setup(lspconfig, base_capabilities)
  lspconfig.tsserver.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
