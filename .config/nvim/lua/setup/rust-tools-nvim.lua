local lsp_status = require("lsp-status")
lsp_status.register_progress()

local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

-- https://github.com/simrat39/rust-tools.nvim#configuration
local rust_tools_opts = {
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
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    on_attach = require("turboladen.lsp.make_on_attach").for_rust,
    capabilities = require("turboladen.lsp").make_capabilities(),
    flags = {
      debounce_text_changes = 350
    },
    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        assist = {
          emitMustUse = true,
          importPrefix = "by_self",
        },
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
        },
        inlayHints = {
          closureCaptureHints = {
            enable = true
          }
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
        typing = {
          autoClosingAngleBrackets = {
            enable = true
          }
        }
      },
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  }
}

require("rust-tools").setup(rust_tools_opts)
