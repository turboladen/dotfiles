local function setup(lspconfig, base_capabilities)
  local json_capabilities = base_capabilities
  json_capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.jsonls.setup({
    -- cmd = { "~/.local/share/nvim/mason/bin/vscode-json-language-server", "--stdio" },
    -- cmd = { "nvm", "exec", "16", "vscode-json-language-server", "--stdio" },
    -- cmd = { "/User/steve.loveless/.nvm/versions/node/v16.16.0/bin/node", "vscode-json-language-server", "--stdio" },
    capabilities = json_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true }
      }
    }
  })
end

return {
  setup = setup
}
