return {
  -- Rust support via rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended to pin to major version
    lazy = false, -- This plugin is already lazy by design
    ft = { "rust" }, -- Only load for Rust files
    config = function()
      -- rustaceanvim configuration
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- Automatically set inlay hints
          inlay_hints = {
            auto = true,
          },
          -- Options for debugging
          test_executor = "background", -- Run tests in background with diagnostics
          -- Code action UI
          code_actions = {
            ui_select_fallback = true,
          },
        },
        -- LSP configuration
        server = {
          -- Override default settings
          default_settings = {
            ["rust-analyzer"] = {
              -- Enable all features for better IDE experience
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for extra help
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {
          -- Auto-configure DAP settings
          autoload_configurations = true,
        },
      }
    end,
  },
}
