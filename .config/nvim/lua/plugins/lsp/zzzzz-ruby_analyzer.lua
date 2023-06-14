local function setup(lspconfig, base_capabilities)
  local configs = require('lspconfig.configs')

  configs.ruby_analyzer = {
    default_config = {
      name = "ruby_analyzer",
      -- cmd = { '/Users/steve.loveless/Development/projects/meowtown/target/release/meowtown' };
      cmd = { '/Users/steve.loveless/Development/projects/ruby_analzyer/target/debug/ruby_analyzer' },
      filetypes = { "ruby" },
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end,
    },
  }

  lspconfig.ruby_analyzer.setup({
    capabilities = base_capabilities,
  })
end

return {
  setup = setup
}
