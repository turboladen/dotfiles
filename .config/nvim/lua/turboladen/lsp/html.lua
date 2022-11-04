local function setup(lspconfig, base_capabilities)
  -- npm i -g vscode-langservers-extracted
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  local html_capabilities = base_capabilities
  html_capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.html.setup({
    capabilities = html_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

return {
  setup = setup
}
