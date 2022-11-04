local function setup(lspconfig, base_capabilities)
  lspconfig.prosemd_lsp.setup({
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
  })
end

-- configs.prosemd = {
--   default_config = {
--     -- Update the path to prosemd-lsp
--     cmd = { "/usr/local/bin/prosemd-lsp", "--stdio" },
--     filetypes = { "markdown" },
--     root_dir = function(fname)
--       return lsp_util.find_git_ancestor(fname) or vim.fn.getcwd()
--     end,
--     settings = {},
--   }
-- }
-- Use your attach function here
-- local lsp = require('lspconfig')
-- lsp.prosemd.setup { on_attach = on_attach }


return {
  setup = setup
}
