--
-- https://github.com/kitten/prosemd-lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#prosemd_lsp
--
local function setup(lspconfig, base_capabilities)
  lspconfig.prosemd_lsp.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
end

return {
  setup = setup
}
