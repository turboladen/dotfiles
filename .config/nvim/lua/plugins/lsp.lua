local function make_attach_things()
  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),

    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local function opts(desc)
        return {
          buffer = ev.buf,
          desc = desc
        }
      end

      vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, opts("Open diagnostic in float"))
      vim.keymap.set('n', '<leader>cl', "<cmd>LspInfo<cr>", opts("LspInfo"))
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Goto definition"))
      vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<cr>", opts("Goto definition"))
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Goto declaration"))
      -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", opts("Show references"))
      -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts("Goto implementation"))
      vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<cr>", opts("Goto implementation"))
      -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gy', "<cmd>Telescope lsp_type_definitinos<cr>", opts("Got t[y]pe definition"))
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'K', require("turboladen.lsp").hover, opts("Show docs"))

      vim.keymap.set('n', 'gK>', vim.lsp.buf.signature_help, opts("Signature help"))
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts("Signature help"))

      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts("Rename"))
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts("Code action"))

      vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts("Previous diagnostic"))
      vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts("Next diagnostic"))
      vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, opts("Add buffer diagnostics to loclist"))

      vim.keymap.set('n', '<leader>co', require("telescope.builtin").lsp_document_symbols, opts("Show doc symbols"))
      vim.keymap.set('n', '<leader>cw', require("telescope.builtin").lsp_dynamic_workspace_symbols,
        opts("Show workspace symbols"))


      -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      --
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts("List workspace folders"))

      vim.keymap.set('n', '<leader>ff', function()
        -- TODO: lspconfig uses true; my old config had false.
        vim.lsp.buf.format { async = true }
        -- vim.lsp.buf.format { async = false }
      end, opts("Format (vis LSP)"))

      require("fidget").setup({})
    end,
  })
end

-- Stole schemastore config from https://github.com/b0o/SchemaStore.nvim/issues/9#issuecomment-1140321123
local function build_yaml_schemas()
  local json_schemas = require('schemastore').json.schemas {}
  local yaml_schemas = {}
  vim.tbl_map(function(schema)
    yaml_schemas[schema.url] = schema.fileMatch
  end, json_schemas)

  return yaml_schemas
end

local function configure_diagnostic_signs()
  for type, icon in pairs(require("turboladen").signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

local function set_diagnostic_config()
  vim.diagnostic.config({
    -- virtual_text = true,
    -- Setting this to false turns off all the annoying rust-analyzer long loop warnings
    -- https://github.com/neovim/nvim-lspconfig/issues/96
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
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
end

return {
  {
    "nvim-lua/lsp-status.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      require("lsp-status").config(opts)
    end
  },
  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │  Portable package manager for Neovim that runs everywhere Neovim         │
  -- │  runs.                                                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = {
          { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
        opts = {},
      },
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_installation = false,
      -- ensure_installed = {
      --   -- "bashls",
      --   -- "cmake",
      --   -- "denols",
      --   -- "dockerls",
      --   "efm", -- general purpose LS
      --   -- "emmet_ls", -- HTML fanciness
      --   -- "eslint",
      --   "jsonls",
      --   "prosemd_lsp",
      --   -- "rust_analyzer",
      --   "solargraph",
      --   "lua_ls",
      --   -- "taplo", -- TOML
      --   -- "terraformls",
      --   -- "tsserver",
      --   "vimls",
      --   -- "yamlls",
      --   -- "zk", -- zk notes, markdown
      -- }
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup(opts)
    end
  },

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

  -- ╭─────────────────────────────────────────────────────────────────╮
  -- │ Tools for better development in rust using neovim's builtin lsp │
  -- ╰─────────────────────────────────────────────────────────────────╯
  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/lsp-status.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
    },
    opts = function()
      return require("plugins.lsp.rust-utils").rust_tools_opts()
    end,
    config = function(_, opts)
      local lsp_status = require("lsp-status")
      lsp_status.register_progress()

      local rust_tools = require("rust-tools")
      rust_tools.setup(opts)

      require("plugins.lsp.rust-utils").make_attach_things(rust_tools)
    end
  },

  -- ╭─────────────────────────────────╮
  -- │ Quickstart configs for Nvim LSP │
  -- ╰─────────────────────────────────╯
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "p00f/clangd_extensions.nvim",
      "b0o/schemastore.nvim",
      { "j-hui/fidget.nvim", tag = "legacy" },
      "nvim-lua/lsp-status.nvim",
      "stevearc/aerial.nvim",
    },
    init = function()
      vim.opt.signcolumn = "yes"
      vim.g.markdown_fenced_languages = { "ts=typescript" }
    end,
    opts = function()
      return {
        diagnostics = {
          underline = true,
          severity_sort = true
        },
        autoformat = true,
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
              }
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
          ruff_lsp = {},
          solargraph = {},
          steep = {},
          sourcekit = {
            -- cmd = { "xcrun", "sourcekit-lsp" },
            filetypes = { "swift", "c", "cpp", "objc", "objcpp", "objective-c", "objective-cpp" },
            root_dir = function()
              return "./"
            end,
          },
          taplo = {},
          terraformls = {},
          tilt_ls = {
            filetypes = { "tiltfile", "bzn" }
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
                schemas = build_yaml_schemas(),
                validate = { enable = true }
              },
            }
          }
        },
        setup = {}
      }
    end,
    config = function(_, opts)
      local lsp_status = require("lsp-status")
      lsp_status.register_progress()

      make_attach_things()
      configure_diagnostic_signs()
      set_diagnostic_config()

      local capabilities = require("plugins.lsp.utils").make_capabilities(opts.capabilities)

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
        require("lspconfig")[server].setup(server_opts)
      end

      -- Get all the servers that are available through mason-lspconfig
      -- local have_mason, mlsp = pcall(require, "mason-lspconfig")
      -- local all_mslp_servers = {}
      -- if have_mason then
      --   all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      -- end

      -- local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(opts.servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          -- if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          setup(server)
          -- else
          -- ensure_installed[#ensure_installed + 1] = server
          -- end
        end
      end

      -- if have_mason then
      --   mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      -- end

      -- if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
      --   local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      --   Util.lsp_disable("tsserver", is_deno)
      --   Util.lsp_disable("denols", function(root_dir)
      --     return not is_deno(root_dir)
      --   end)
      -- end

      -- NOTE: 07-jun-23. Commenting out for now since this would try to format all filetypes,
      -- even if it doesn't have an LSP.
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('lsp_formatting', {}),
        callback = function()
          -- TODO: Should check, if possible, if the LSP supports this before calling it.
          vim.lsp.buf.format()
        end
      })

      vim.api.nvim_create_autocmd('CursorHold', {
        group = vim.api.nvim_create_augroup('lsp_open_float_on_cursor_hold', {}),
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false })
        end
      })
    end
  },

  {
    "onsails/lspkind-nvim",
    opts = {
      mode = "symbol"
    },
    config = function(_, opts)
      require("lspkind").init(opts)
    end
  }
}
