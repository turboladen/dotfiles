local Plugin = { 'mrcjkb/rustaceanvim' }

Plugin.version = '^4'
Plugin.ft = { 'rust' }

Plugin.opts = {
  tools = {
    crate_graph = {
      full = false,
      backend = "png",
      output = "./crate-graph.png",
    },
    inlay_hints = {
      only_current_line = true,
    },
  },
  server = {
    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        assist = {
          emitMustUse = true,
        },
        cargo = {
          features = "all",
        },
        -- checkOnSave = {
        --   command = "clippy",
        -- },
        inlayHints = {
          closureCaptureHints = {
            enable = true
          },
          lifetimeElisionHints = {
            enable = true
          },
          rangeExclusiveHints = {
            enable = true
          },
        },
        lens = {
          references = {
            adt = {
              enable = true
            },
            enumVariant = {
              enable = true
            },
            method = {
              enable = true
            },
            trait = {
              enable = true
            },
          },
        },
        -- typing = {
        --   autoClosingAngleBrackets = {
        --     enable = true
        --   }
        -- }
      },
    },
  },
}

Plugin.config = function(_, opts)
  vim.g.rustaceanvim = opts
end

return Plugin
