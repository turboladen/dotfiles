--
-- https://github.com/mattn/efm-langserver
-- brew install efm-langserver
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#efm
-- Config for EFM is in ~/.config/efm-langserver/config.yaml
--
local function setup(lspconfig, base_capabilities)
  lspconfig.efm.setup({
    init_options = {
      documentFormatting = true
    },
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
    filetypes = {
      "bash",
      "make",
      "markdown",
      "sh",
      "text",
      "yaml",
      "yaml.docker-compose",
      "zsh",
    }
  })
end

return {
  setup = setup
}