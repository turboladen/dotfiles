--
-- https://github.com/hrsh7th/vscode-langservers-extracted
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
--
local function setup(lspconfig, base_capabilities)
  lspconfig.eslint.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    settings = {
      packageManger = "yarn",
    }
  })
end

return {
  setup = setup
}
