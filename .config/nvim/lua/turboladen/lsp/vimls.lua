--
-- https://github.com/iamcco/vim-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
-- npm install -g vim-language-server
--
local function setup(lspconfig, base_capabilities)
  lspconfig.vimls.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
end

return {
  setup = setup
}
