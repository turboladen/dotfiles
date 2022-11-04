--
-- https://solargraph.org/
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
--
local function setup(lspconfig, base_capabilities)
  lspconfig.solargraph.setup({
    -- init_options = {
    --   documentFormatting = true
    -- },
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
