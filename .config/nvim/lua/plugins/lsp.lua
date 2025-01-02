for type, icon in pairs(require("turboladen").lsp_diagnostic_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    severity = "ERROR"
  },
  -- Setting this to false turns off all the annoying rust-analyzer long loop warnings
  -- https://github.com/neovim/nvim-lspconfig/issues/96
  -- virtual_text = false,
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

require("clangd_extensions").setup({
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
})

vim.g.rustaceanvim = {
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

-- ╭───────────╮
-- │ lspconfig │
-- ╰───────────╯
local opts = {
  servers = {
    asm_lsp = {
      filetypes = { "asm", "nasm", "vmasm" },
      root_dir = function()
        return "./"
      end
    },
    bashls = {},

    -- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
    -- │ https://deno.land/manual@v1.27.1/language_server                                        │
    -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#denols│
    -- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
    denols = {},

    dockerls = {},

    dprint = {},

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
      },
      init_options = {
        provideFormatter = false
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
    neocmake = {},
    reason_ls = {},
    -- ruby_analyzer = {
    -- },
    ruff = {},
    ruby_lsp = {
      formatter = "standard"
    },
    -- solargraph = {},
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
    ts_ls = {},
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
          schemas = require("plugins.schemastore").lspconfig_yaml_schemas(),
          validate = { enable = true }
        },
      }
    }
  },
  setup = {
    -- ruby_analyzer = {}
  },
}

require("user.commands").lspconfig()
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()

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
-- for server, config in pairs(opts.servers) do
--   -- passing config.capabilities to blink.cmp merges with the capabilities in your
--   -- `opts[server].capabilities, if you've defined it
--   config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
--   lspconfig[server].setup(config)
-- end
