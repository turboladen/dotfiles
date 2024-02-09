local Plugin = { "neovim/nvim-lspconfig" }
local user = {}


Plugin.dependencies = {
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'williamboman/mason-lspconfig.nvim' },
  { "b0o/schemastore.nvim" },
  -- ╭─────────────────────────────────────────────────────────────╮
  -- │ Disabling because noice provides its own version of fidget. │
  -- ╰─────────────────────────────────────────────────────────────╯
  -- { "j-hui/fidget.nvim" },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = { 'rust' },
  },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = { "rust" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-lua/lsp-status.nvim",
  --     "neovim/nvim-lspconfig",
  --     "mfussenegger/nvim-dap",
  --   },
  --   opts = function()
  --     return require("plugins.lsp.rust-utils").rust_tools_opts()
  --   end,
  --   config = function(_, opts)
  --     local rust_tools = require("rust-tools")
  --     rust_tools.setup(opts)
  --
  --     require("plugins.lsp.rust-utils").make_attach_things(rust_tools)
  --   end
  -- },
  --  ╭────────────────────────────────────────────────────╮
  --  │ Clangd's off-spec features for neovim's LSP client │
  --  ╰────────────────────────────────────────────────────╯
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    opts = {
      server = {
        default_config = {
          cmd = { "clangd", "--enable-config", "--clang-tidy", "--background-index" }
        }
      },
      extensions = {
        inlay_hints = {
          only_current_line = true
        }
      }
    }
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ lsp_lines is a simple neovim plugin that renders        │
  -- │ diagnostics using virtual lines on top of the real      │
  -- │ line of code.                                           │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    end,
  }
}

Plugin.cmd = { 'LspInfo', 'LspInstall', 'LspUnInstall' }

Plugin.event = { 'BufReadPre', 'BufNewFile' }

function Plugin.init()
  for type, icon in pairs(require("turboladen").lsp_diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    -- virtual_text = true,
    -- Setting this to false turns off all the annoying rust-analyzer long loop warnings
    -- https://github.com/neovim/nvim-lspconfig/issues/96
    virtual_text = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'always',
      -- header = '',
      -- prefix = '',
    },
    ["neotest"] = {
      log_level = vim.log.levels.ERROR
    }
  })

  -- ╭──────────────────────────────────────────╮
  -- │ Disabling while trying out lsp_line.nvim │
  -- ╰──────────────────────────────────────────╯
  -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  --   vim.lsp.handlers.hover,
  --   { border = 'rounded' }
  -- )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )
end

function Plugin.opts()
  return {
    servers = {
      asm_lsp = {
        filetypes = { "asm", "nasm", "vmasm" },
        root_dir = function()
          return "./"
        end
      },
      bashls = {},
      cmake = {},

      -- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://deno.land/manual@v1.27.1/language_server                                        │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#denols│
      -- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
      denols = {},

      dockerls = {},

      -- ╭───────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://github.com/mattn/efm-langserver                                               │
      -- │ brew install efm-langserver                                                           │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#efm │
      -- │ Config for EFM is in ~/.config/efm-langserver/config.yaml                             │
      -- ╰───────────────────────────────────────────────────────────────────────────────────────╯
      efm = {
        init_options = {
          documentFormatting = true
        },
        filetypes = {
          "bash",
          "make",
          "markdown",
          "sh",
          "text",
          "yaml",
          "yaml.docker-compose",
          "zsh",
        }
      },

      -- ╭───────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://github.com/aca/emmet-ls                                                           │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls│
      -- ╰───────────────────────────────────────────────────────────────────────────────────────────╯
      emmet_ls = {
        init_options = {
          html = {
            options = {
              -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
              --
              -- Tag case: lower, upper or '' (keep as-is)
              ["output.tagCase"] = "lower",
              ["output.attributeQuotes"] = "double",
              ["output.format"] = true,
              ["bem.enabled"] = true,
            },
          },
        }
      },

      -- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://github.com/hrsh7th/vscode-langservers-extracted                                 │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint│
      -- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
      eslint = {
        settings = {
          packageManger = "yarn",
        }
      },

      gradle_ls = {},

      -- ╭───────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://github.com/hrsh7th/vscode-langservers-extracted                               │
      -- │ npm i -g vscode-langservers-extracted                                                 │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html│
      -- ╰───────────────────────────────────────────────────────────────────────────────────────╯
      html = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true
              }
            }
          }
        }
      },

      -- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://github.com/hrsh7th/vscode-langservers-extracted                                 │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls│
      -- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
      jsonls = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true
              }
            }
          }
        },
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true }
          },
        }
      },
      marksman = {},

      -- ╭──────────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://github.com/sumneko/lua-language-server                                               │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua│
      -- ╰──────────────────────────────────────────────────────────────────────────────────────────────╯
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              -- https://github.com/LuaLS/lua-language-server/wiki/Libraries#environment-emulation
              -- https://github.com/folke/neodev.nvim/issues/88
              checkThirdParty = false,
            },
            telemetry = {
              enable = false
            }
          },
        }
      },
      prosemd_lsp = {},
      pyright = {},
      reason_ls = {},
      -- ruby_analyzer = {
      -- },
      ruff_lsp = {},
      solargraph = {},
      -- steep = {},
      -- sourcekit = {
      --   -- cmd = { "xcrun", "sourcekit-lsp" },
      --   filetypes = { "swift", "c", "cpp", "objc", "objcpp", "objective-c", "objective-cpp" },
      --   root_dir = function()
      --     return "./"
      --   end,
      -- },
      taplo = {},
      terraformls = {},
      tilt_ls = {
        filetypes = { "tiltfile", "bzl" }
      },
      tsserver = {},
      -- typeprof = {},
      vimls = {},

      -- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ https://github.com/redhat-developer/yaml-language-server                                │
      -- │ yarn global add yaml-language-server                                                    │
      -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls│
      -- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
      yamlls = {
        settings = {
          yaml = {
            -- Stole schemastore config from https://github.com/b0o/SchemaStore.nvim/issues/9#issuecomment-1140321123
            schemas = function()
              local json_schemas = require('schemastore').json.schemas {}
              local yaml_schemas = {}
              vim.tbl_map(function(schema)
                yaml_schemas[schema.url] = schema.fileMatch
              end, json_schemas)

              return yaml_schemas
            end,
            validate = { enable = true }
          },
        }
      }
    },
    setup = {
      -- ruby_analyzer = {}
    },
  }
end

function Plugin.config(_, opts)
  require("user.commands").lspconfig()

  local lspconfig = require('lspconfig')
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, opts.servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return
      end
    end
    lspconfig[server].setup(server_opts)
  end

  -- local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(opts.servers) do
    server_opts = server_opts == true and {} or server_opts
    setup(server)
  end
end

return Plugin
