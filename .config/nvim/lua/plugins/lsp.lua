return {
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- Enhanced capabilities with blink.cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink then
        capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
      end

      -- Configure global LSP defaults for ALL servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        float = {
          source = "always",
          border = "rounded",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Use the 0.11 LspAttach event for all LSP setup
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf

          -- Enable codelens if supported
          if client:supports_method("textDocument/codeLens") then
            vim.lsp.codelens.refresh({ bufnr = bufnr })
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = bufnr,
              group = vim.api.nvim_create_augroup("lsp-codelens", { clear = false }),
              callback = function()
                vim.lsp.codelens.refresh({ bufnr = bufnr })
              end,
            })
          end

          -- Buffer local mappings
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
          end

          -- Navigation keymaps
          map("gd", vim.lsp.buf.definition, "LSP: Goto definition")
          map("gD", vim.lsp.buf.declaration, "LSP: Goto declaration")
          map("gi", vim.lsp.buf.implementation, "LSP: Goto implementation")
          map("gC", vim.lsp.buf.incoming_calls, "LSP: Incoming calls")
          map(
            "gR",
            "<cmd>Trouble lsp_references toggle focus=false<cr>",
            "LSP: References (Trouble)"
          )
          map("gy", vim.lsp.buf.type_definition, "LSP: Type definition")

          -- Hover and signature help
          map("K", vim.lsp.buf.hover, "LSP: Show docs")

          -- Document/workspace symbols
          map("<leader>ds", vim.lsp.buf.document_symbol, "LSP: Doc symbols")
          map("<leader>ws", vim.lsp.buf.workspace_symbol, "LSP: Workspace symbols")

          -- Code actions and refactoring
          map("<leader>la", vim.lsp.buf.code_action, "LSP: Code action")
          vim.keymap.set(
            "v",
            "<leader>la",
            vim.lsp.buf.code_action,
            { buffer = bufnr, desc = "LSP: Code action" }
          )
          map("<leader>lr", vim.lsp.buf.rename, "LSP: Rename")
          map("<leader>ls", vim.lsp.buf.signature_help, "LSP: Signature help")

          -- Formatting (for languages where LSP formatting is preferred)
          -- External formatters are configured in plugins/formatting.lua
          map("<leader>lf", vim.lsp.buf.format, "LSP: Format buffer")

          -- Diagnostics navigation
          map("]g", vim.diagnostic.goto_next, "LSP: Next diagnostic")
          map("[g", vim.diagnostic.goto_prev, "LSP: Prev diagnostic")

          -- Workspace management
          map("<leader>lw", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "LSP: List folders")

          -- Diagnostic viewing
          map("<leader>lx", function()
            require("fzf-lua").diagnostics({ bufnr = 0, severity = "Error" })
          end, "LSP: Buffer errors")
          map("<leader>lX", function()
            require("fzf-lua").diagnostics({ severity = "Error" })
          end, "LSP: All errors")
          map("<leader>ld", function()
            require("fzf-lua").diagnostics({ bufnr = 0 })
          end, "LSP: Buffer diagnostics")
          map("<leader>lD", function()
            require("fzf-lua").diagnostics()
          end, "LSP: All diagnostics")

          -- Codelens mappings
          if client:supports_method("textDocument/codeLens") then
            map("<leader>ll", vim.lsp.codelens.run, "LSP: Codelens run")
            map("<leader>lc", function()
              vim.lsp.codelens.refresh({ bufnr = bufnr })
            end, "LSP: Codelens refresh")
          end

          -- Document highlighting
          if client:supports_method("textDocument/documentHighlight") then
            local highlight_augroup =
              vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = bufnr,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = bufnr,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Note: Language servers are configured in their respective lang/*.lua files
      -- rust-analyzer: handled by rustaceanvim in lang/rust.lua
      -- lua_ls: configured in lang/lua.lua
      -- ruby_lsp: configured in lang/ruby.lua
      -- marksman: configured in lang/markdown.lua
    end,
  },

  -- Import language-specific configurations
  { import = "plugins.lang" },
  { import = "plugins.extras.lang.asm" },
  { import = "plugins.extras.lang.bash" },
  { import = "plugins.extras.lang.clangd" },
  { import = "plugins.extras.lang.docker" },
  { import = "plugins.extras.lang.html" },
  { import = "plugins.extras.lang.just" },
  { import = "plugins.extras.lang.python" },
  { import = "plugins.extras.lang.ruby" },
  { import = "plugins.extras.lang.sql" },
  { import = "plugins.extras.lang.terraform" },
  { import = "plugins.extras.lang.typescript" },
  { import = "plugins.extras.lang.xml" },
  { import = "plugins.extras.lang.zsh" },
}
