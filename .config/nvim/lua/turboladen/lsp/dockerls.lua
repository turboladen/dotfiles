--
-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
-- npm install -g dockerfile-language-server-nodejs
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
--
local function setup(lspconfig, base_capabilities)
  lspconfig.dockerls.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })

end

return {
  setup = setup
}
