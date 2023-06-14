-- ╭──────────────────────────────────────────────────────────────────────────────────────────────╮
-- │ https://github.com/sumneko/lua-language-server                                               │
-- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua│
-- ╰──────────────────────────────────────────────────────────────────────────────────────────────╯
-- local function setup(lspconfig, base_capabilities)
--   lspconfig.lua_ls.setup({
--     capabilities = base_capabilities,
--     settings = {
--       Lua = {
--         runtime = {
--           version = "LuaJIT",
--         },
--         diagnostics = {
--           globals = { "vim" },
--         },
--         workspace = {
--           -- Make the server aware of Neovim runtime files
--           library = vim.api.nvim_get_runtime_file("", true),
--           -- https://github.com/LuaLS/lua-language-server/wiki/Libraries#environment-emulation
--           -- https://github.com/folke/neodev.nvim/issues/88
--           checkThirdParty = false,
--         },
--         telemetry = {
--           enable = false
--         }
--       },
--     }
--   })
-- end

-- return {
--   setup = setup
-- }
