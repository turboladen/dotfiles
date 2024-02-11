local Plugin = { 'mrcjkb/rustaceanvim' }

Plugin.version = '^4'
Plugin.ft = { 'rust' }

-- Plugin.init = function()
--   vim.g.rustaceanvim = {
--     tools = {
--       crate_graph = {
--         full = false,
--         backend = "png",
--         output = "./crate-graph.png",
--       },
--       inlay_hints = {
--         only_current_line = true,
--       },
--     },
--     server = {
--       default_settings = {
--         -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--         ["rust-analyzer"] = {
--           assist = {
--             emitMustUse = true,
--             importPrefix = "by_self",
--           },
--           cargo = {
--             allFeatures = true,
--           },
--           checkOnSave = {
--             command = "clippy",
--           },
--           inlayHints = {
--             closureCaptureHints = {
--               enable = true
--             }
--           },
--           lens = {
--             references = {
--               adt = {
--                 enable = true
--               },
--               enumVariant = {
--                 enable = true
--               },
--               method = {
--                 enable = true
--               },
--               trait = {
--                 enable = true
--               },
--             },
--           },
--           procMacro = {
--             enable = true
--           },
--           typing = {
--             autoClosingAngleBrackets = {
--               enable = true
--             }
--           }
--         },
--       },
--     },
--   }
-- end

return Plugin
