local function setup(base_capabilities)
  require("clangd_extensions").setup({
    server = {
      capabilities = base_capabilities,
      on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
      default_config = {
        cmd = { "clangd", "--enable-config", "--clang-tidy", "--background-index" }
      }
    },
    extensions = {
      inlay_hints = {
        only_current_line = true
      }
    }
  })
end

return {
  setup = setup
}
