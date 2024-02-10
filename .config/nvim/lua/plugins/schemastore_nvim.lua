local Plugin = { "b0o/schemastore.nvim" }

-- Stole schemastore config from https://github.com/b0o/SchemaStore.nvim/issues/9#issuecomment-1140321123
Plugin.lspconfig_yaml_schemas = function()
  local json_schemas = require('schemastore').json.schemas {}
  local yaml_schemas = {}
  vim.tbl_map(function(schema)
    yaml_schemas[schema.url] = schema.fileMatch
  end, json_schemas)

  return yaml_schemas
end

return Plugin
