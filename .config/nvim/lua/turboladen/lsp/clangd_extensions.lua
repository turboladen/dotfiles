local function setup(base_capabilities)
  require("clangd_extensions").setup({
    server = {
      capabilities = base_capabilities,
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
