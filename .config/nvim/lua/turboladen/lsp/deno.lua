--
-- https://deno.land/manual@v1.27.1/language_server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#denols
--
local function setup(lspconfig, base_capabilities)
  vim.g.markdown_fenced_languages = {
    "ts=typescript"
  }

  lspconfig.denols.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
