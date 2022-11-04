--
-- https://github.com/hashicorp/terraform-ls
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#terraformls
--
local function setup(lspconfig, base_capabilities)
  lspconfig.terraformls.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
