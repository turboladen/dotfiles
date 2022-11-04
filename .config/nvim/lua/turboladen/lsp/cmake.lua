--
-- https://github.com/regen100/cmake-language-server
-- pip install cmake-language-server
--
local function setup(lspconfig, base_capabilities)
  lspconfig.cmake.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
