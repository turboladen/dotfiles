-- local function make_lua_cmd()
--   -- brew install lua-language-server
--   local sumneko_binary = require("turboladen/homebrew").prefix() .. "/bin/lua-language-server"

--   return { sumneko_binary }
-- end

local function make_lua_settings()
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local runtime_files = vim.api.nvim_get_runtime_file("", true)
  vim.tbl_extend("keep", runtime_files, {
    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
  })

  return {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false
      }
    },
  }
end

--
-- https://github.com/sumneko/lua-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
--
local function setup(lspconfig, base_capabilities)
  lspconfig.sumneko_lua.setup({
    -- cmd = make_lua_cmd(),
    capabilities = base_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
    settings = make_lua_settings(),
  })
end

return {
  setup = setup
}
