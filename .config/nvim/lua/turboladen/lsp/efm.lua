--
-- Config for EFM is in ~/.config/efm-langserver/config.yaml
--
local function setup(lspconfig, base_capabilities)
  -- brew install efm-langserver
  -- https://github.com/mattn/efm-langserver
  lspconfig.efm.setup({
    init_options = {
      documentFormatting = true
    },
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
    filetypes = {
      "bash",
      "markdown",
      "sh",
      "text",
      "yaml",
      "zsh",
    }
  })
end

return {
  setup = setup
}
