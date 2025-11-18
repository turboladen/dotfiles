-- Dependencies to install:
-- deno: brew install deno (includes deno lsp, deno fmt, deno lint)

return {
  -- Treesitter parsers (reuse existing TS/JS parsers)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typescript", "tsx", "javascript" },
    },
  },

  -- Deno LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure denols with enhanced import suggestions and inlay hints
      vim.lsp.config("denols", {
        settings = {
          deno = {
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true,
                  ["https://cdn.skypack.dev"] = true,
                  ["https://esm.sh"] = true,
                },
              },
            },
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })

      vim.lsp.enable("denols")
    end,
  },

  -- Deno linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      -- Only lint in Deno projects (detected by deno.json presence)
      -- This prevents conflicts with regular TS/JS linting
      opts.linters_by_ft.typescript = opts.linters_by_ft.typescript or {}
      opts.linters_by_ft.javascript = opts.linters_by_ft.javascript or {}

      -- Add deno lint only if in a deno project
      local function is_deno_project()
        return vim.fn.filereadable("deno.json") == 1 or vim.fn.filereadable("deno.jsonc") == 1
      end

      if is_deno_project() then
        table.insert(opts.linters_by_ft.typescript, "deno")
        table.insert(opts.linters_by_ft.javascript, "deno")
      end

      return opts
    end,
  },

  -- Filetype detection for Deno projects
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      -- Set up autocmd to configure Deno-specific settings
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
        callback = function()
          -- Check if we're in a Deno project
          local deno_config = vim.fn.findfile("deno.json", ".;")
          local deno_config_jsonc = vim.fn.findfile("deno.jsonc", ".;")

          if deno_config ~= "" or deno_config_jsonc ~= "" then
            -- Set buffer-local variable to indicate this is a Deno file
            vim.b.is_deno_project = true
          end
        end,
      })
    end,
  },
}
