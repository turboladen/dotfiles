--
-- https://github.com/ruby/typeprof
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#typeprof
--
local function setup(lspconfig, base_capabilities)
  -- gem install typeprof
  lspconfig.typeprof.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
end

return {
  setup = setup
}
