-- ╭───────────────────────────────────────────────────────────────────────────────────────────╮
-- │ https://github.com/aca/emmet-ls                                                           │
-- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls│
-- ╰───────────────────────────────────────────────────────────────────────────────────────────╯
local function setup(lspconfig, base_capabilities)
  lspconfig.emmet_ls.setup({
    capabilities = base_capabilities,
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          --
          -- Tag case: lower, upper or '' (keep as-is)
          ["output.tagCase"] = "lower",
          ["output.attributeQuotes"] = "double",
          ["output.format"] = true,
          ["bem.enabled"] = true,
        },
      },
    }
  })
end

return {
  setup = setup
}
