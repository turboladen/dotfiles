-- Code formatting with conform.nvim
--
-- Strategy: Only use external formatters when LSP formatting is inadequate
-- - Rust: LSP only (rust-analyzer calls rustfmt internally)
-- - Lua: Formatter only (stylua > lua_ls formatting)
-- - Markdown: LSP only (dprint LSP > marksman formatting)
-- - JSON: LSP only (dprint LSP > jsonls formatting)
-- - JavaScript/TypeScript: LSP only (dprint LSP when available)
-- - YAML: Formatter only (dprint, yamlls doesn't format)
-- - TOML: LSP only (taplo LSP includes excellent formatting)
--
-- Global config locations:
-- - dprint: ~/.dprint.jsonc (global) or dprint.json/dprint.jsonc (project root)
-- - marksman: ~/.config/marksman/config.toml

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>=",
        function()
          require("conform").format({ async = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer/selection",
      },
    },
    opts = {
      -- Define formatters by filetype (only where external formatter is better than LSP)
      formatters_by_ft = {
        -- Languages where external formatters are superior
        lua = { "stylua" }, -- stylua > lua_ls formatting
        -- YAML formatting is handled in lua/plugins/lang/yaml.lua via dprint
        fish = { "fish_indent" }, -- fish_indent > fish_lsp formatting

        -- Languages for extras (when LSP isn't available)
        sh = { "shfmt" },

        -- Note: These languages now use LSP formatting:
        -- - Rust: rust-analyzer calls rustfmt internally
        -- - TOML: taplo LSP includes formatting
        -- - Markdown: dprint LSP > marksman formatting
        -- - JSON: dprint LSP > jsonls formatting
        -- - JavaScript/TypeScript: dprint LSP when available
      },

      -- Formatter customizations are defined in their respective lang/*.lua files

      -- Format on save - use the best formatter for each language
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        -- Get the filetype
        local ft = vim.bo[bufnr].filetype

        -- For these languages, use LSP formatting (they have excellent LSP formatters)
        local lsp_format_languages = {
          "rust",
          "toml",
          "python",
          "ruby",
          "markdown",
          "json",
          "jsonc",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        }

        if vim.tbl_contains(lsp_format_languages, ft) then
          return {
            timeout_ms = 500,
            lsp_format = "prefer", -- Use LSP for these languages
          }
        else
          return {
            timeout_ms = 500,
            lsp_format = "never", -- Use external formatters for others
          }
        end
      end,

      -- Notify on format errors but not missing formatters (LSP might handle it)
      notify_on_error = true,
      notify_no_formatters = false,
    },

    config = function(_, opts)
      require("conform").setup(opts)

      -- Create commands to toggle auto-formatting
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.g.disable_autoformat = true
        else
          vim.b.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
