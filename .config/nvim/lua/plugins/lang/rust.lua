-- Dependencies to install:
-- rustaceanvim handles rust-analyzer automatically
-- crates.nvim is installed via plugin manager

return {
  -- Treesitter Rust parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rust" },
    },
  },

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
                -- Better workspace discovery
                autoreload = true,
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
              -- Workspace and project discovery
              linkedProjects = {},
              files = {
                watcherExclude = {
                  "**/.git/**",
                  "**/target/**",
                  "**/node_modules/**",
                },
              },
              -- Diagnostics
              diagnostics = {
                enable = true,
                experimental = {
                  enable = true,
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

  -- Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function(_, opts)
      require("crates").setup(opts)

      -- Add keymaps when Cargo.toml is opened
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CratesNvimKeymaps", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local map = function(keys, func, desc)
            vim.keymap.set(
              "n",
              keys,
              func,
              { silent = true, buffer = bufnr, desc = "Crates: " .. desc }
            )
          end

          -- Toggle and reload
          map("<leader>rt", require("crates").toggle, "Toggle info")
          map("<leader>rr", require("crates").reload, "Reload cache")

          -- Show popups
          map("<leader>rv", require("crates").show_versions_popup, "Show versions")
          map("<leader>rf", require("crates").show_features_popup, "Show features")
          map("<leader>rd", require("crates").show_dependencies_popup, "Show dependencies")

          -- Update and upgrade
          map("<leader>ru", require("crates").update_crate, "Update crate")
          map("<leader>rU", require("crates").upgrade_crate, "Upgrade crate")
          map("<leader>ra", require("crates").update_all_crates, "Update all")
          map("<leader>rA", require("crates").upgrade_all_crates, "Upgrade all")

          -- Extract crate info
          map(
            "<leader>rx",
            require("crates").expand_plain_crate_to_inline_table,
            "Extract to inline table"
          )
          map("<leader>rX", require("crates").extract_crate_into_table, "Extract into table")

          -- Open external links
          map("<leader>rH", require("crates").open_homepage, "Open homepage")
          map("<leader>rR", require("crates").open_repository, "Open repository")
          map("<leader>rD", require("crates").open_documentation, "Open documentation")
        end,
      })
    end,
  },
}
