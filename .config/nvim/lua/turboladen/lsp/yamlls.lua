-- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
-- │ https://github.com/redhat-developer/yaml-language-server                                │
-- │ yarn global add yaml-language-server                                                    │
-- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls│
-- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
local function setup(lspconfig, base_capabilities)
  -- Stole schemastore config from https://github.com/b0o/SchemaStore.nvim/issues/9#issuecomment-1140321123
  local json_schemas = require('schemastore').json.schemas {}
  local yaml_schemas = {}
  vim.tbl_map(function(schema)
    yaml_schemas[schema.url] = schema.fileMatch
  end, json_schemas)

  lspconfig.yamlls.setup({
    capabilities = base_capabilities,
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
