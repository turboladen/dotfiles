-- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
-- │ https://github.com/hrsh7th/vscode-langservers-extracted                                 │
-- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint│
-- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
local function setup(lspconfig, base_capabilities)
  lspconfig.eslint.setup({
    capabilities = base_capabilities,
    settings = {
      packageManger = "yarn",
    }
  })
end

return {
  setup = setup
}
