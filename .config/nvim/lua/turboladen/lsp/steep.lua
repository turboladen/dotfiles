--
-- https://github.com/soutaro/steep
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#steep
--
local function setup(lspconfig, base_capabilities)
  lspconfig.steep.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })

end

return {
  setup = setup
}
