--
-- cargo install taplo-cli
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#taplo
--
local function setup(lspconfig, base_capabilities)
  lspconfig.taplo.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}