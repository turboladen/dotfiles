local function setup(lspconfig, base_capabilities)
  -- yarn global add yaml-language-server
  -- https://github.com/redhat-developer/yaml-language-server
  -- Stole schemastore config from https://github.com/b0o/SchemaStore.nvim/issues/9#issuecomment-1140321123
  local json_schemas = require('schemastore').json.schemas {}
  local yaml_schemas = {}
  vim.tbl_map(function(schema)
    yaml_schemas[schema.url] = schema.fileMatch
  end, json_schemas)

  lspconfig.yamlls.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    settings = {
      yaml = {
        schemas = yaml_schemas,
        validate = { enable = true }
      },
    }
  })

end

return {
  setup = setup
}
