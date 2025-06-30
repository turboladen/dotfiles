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
          map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          -- Commenting out for now; neovim now defaults to use `gri` for this.
          -- map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          map("gC", vim.lsp.buf.incoming_calls, "[G]oto incoming [C]alls")
          map(
            "gR",
            "<cmd>Trouble lsp_references toggle focus=false<cr>",
            "[G]oto [R]eferences (Trouble)"
          )
          map("gy", vim.lsp.buf.type_definition, "[G]oto t[y]pe definition")

          -- Hover and signature help
          map("K", vim.lsp.buf.hover, "Show docs")

          -- Document/workspace symbols
          -- Commenting below; neovim now defaults to use `gO` for this.
          -- map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
          map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")

          -- Code actions and refactoring
          map("<leader>la", vim.lsp.buf.code_action, "Code [A]ction")
          vim.keymap.set(
            "v",
            "<leader>la",
            vim.lsp.buf.code_action,
            { buffer = bufnr, desc = "LSP: Code [A]ction" }
          )
          map("<leader>lr", vim.lsp.buf.rename, "[R]ename")
          map("<leader>ls", vim.lsp.buf.signature_help, "[S]ignature help")

          -- Formatting
          map("<leader>=", vim.lsp.buf.format, "Format buffer")

          -- Diagnostics navigation
          map("]g", vim.diagnostic.goto_next, "Next diagnostic")
          map("[g", vim.diagnostic.goto_prev, "Previous diagnostic")

          -- Workspace management
          map("<leader>lf", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List workspace [F]olders")

          -- Diagnostic viewing
          map("<leader>lx", function()
            require("fzf-lua").diagnostics({ bufnr = 0, severity = "Error" })
          end, "Buffer errors")
          map("<leader>lX", function()
            require("fzf-lua").diagnostics({ severity = "Error" })
          end, "All errors")
          map("<leader>ld", function()
            require("fzf-lua").diagnostics({ bufnr = 0 })
          end, "Buffer diagnostics")
          map("<leader>lD", function()
            require("fzf-lua").diagnostics()
          end, "All diagnostics")

          -- Codelens mappings
          if client:supports_method("textDocument/codeLens") then
            map("<leader>ll", vim.lsp.codelens.run, "[L]SP Code[l]ens Run")
            map("<leader>lr", function()
              vim.lsp.codelens.refresh({ bufnr = bufnr })
            end, "[L]SP Code[l]ens [R]efresh")
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
  -- Language extras are now loaded via config.extras
}
