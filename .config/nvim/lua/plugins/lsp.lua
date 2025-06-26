-- ╭─────────────────────────────────╮
-- │ Quickstart configs for Nvim LSP │
-- ╰─────────────────────────────────╯
require("lspkind").init({
  mode = "symbol",
})

for type, icon in pairs(require("turboladen").lsp_diagnostic_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  -- virtual_text = {
  --   severity = "ERROR",
  -- },
  -- Setting this to false turns off all the annoying rust-analyzer long loop warnings
  -- https://github.com/neovim/nvim-lspconfig/issues/96
  virtual_text = false, -- turned off for trying lsp_lines.nvim
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    -- header = '',
    -- prefix = '',
  },
  ["neotest"] = {
    log_level = vim.log.levels.ERROR,
  },
})

-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

require("lsp_lines").setup()

-- ╭───────────╮
-- │ lspconfig │
-- ╰───────────╯
local opts = {
  -- options for vim.diagnostic.config()
  ---@type vim.diagnostic.Opts
  diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      -- prefix = "icons",
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = require("turboladen").lsp_diagnostic_signs.Error,
        [vim.diagnostic.severity.WARN] = require("turboladen").lsp_diagnostic_signs.Warn,
        [vim.diagnostic.severity.HINT] = require("turboladen").lsp_diagnostic_signs.Hint,
        [vim.diagnostic.severity.INFO] = require("turboladen").lsp_diagnostic_signs.Info,
      },
    },
  },
  -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  -- Be aware that you also will need to properly configure your LSP server to
  -- provide the inlay hints.
  inlay_hints = {
    enabled = true,
    -- exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
  },
  -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
  -- Be aware that you also will need to properly configure your LSP server to
  -- provide the code lenses.
  codelens = {
    enabled = true,
  },
  -- add any global capabilities here
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
  servers = {
    asm_lsp = {
      filetypes = { "asm", "nasm", "vmasm" },
      root_dir = function()
        return "./"
      end,
    },
    bashls = {},
    clangd = {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    },
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
        documentFormatting = true,
      },
      filetypes = {
        "bash",
        "make",
        "sh",
        "text",
        "yaml",
        "yaml.docker-compose",
        "zsh",
      },
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
      },
    },

    -- ╭─────────────────────────────────────────────────────────────────────────────────────────╮
    -- │ https://github.com/hrsh7th/vscode-langservers-extracted                                 │
    -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint│
    -- ╰─────────────────────────────────────────────────────────────────────────────────────────╯
    eslint = {
      settings = {
        packageManger = "yarn",
      },
    },
    gleam = {},

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
              snippetSupport = true,
            },
          },
        },
      },
      init_options = {
        provideFormatter = false,
      },
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
              snippetSupport = true,
            },
          },
        },
      },
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
    marksman = {},

    -- ╭──────────────────────────────────────────────────────────────────────────────────────────────╮
    -- │ https://github.com/sumneko/lua-language-server                                               │
    -- │ https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua│
    -- ╰──────────────────────────────────────────────────────────────────────────────────────────────╯
    lua_ls = {
      settings = {
        Lua = {
          codeLens = {
            enable = true,
          },
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim" },
          },
          doc = {
            privateName = { "^_" },
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
          runtime = {
            version = "LuaJIT",
          },
          telemetry = {
            enable = false,
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            -- library = vim.api.nvim_get_runtime_file("", true),
            -- https://github.com/LuaLS/lua-language-server/wiki/Libraries#environment-emulation
            -- https://github.com/folke/neodev.nvim/issues/88
            checkThirdParty = false,
          },
        },
      },
    },
    prosemd_lsp = {},
    pyright = {},
    neocmake = {},
    reason_ls = {},
    -- ruby_analyzer = {
    -- },
    ruff = {},
    ruby_lsp = {
      formatter = "standard",
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
      filetypes = { "tiltfile", "bzl" },
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
          schemas = require("turboladen.schemastore").lspconfig_yaml_schemas(),
          validate = { enable = true },
        },
      },
    },
  },
  setup = {
    -- ruby_analyzer = {}
  },
}

require("user.commands").lspconfig()
local lspconfig = require("lspconfig")
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server, config in pairs(opts.servers) do
  -- passing config.capabilities to blink.cmp merges with the capabilities in your
  -- `opts[server].capabilities, if you've defined it
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  lspconfig[server].setup(config)
end

-- local function setup_server(server)
--   local server_opts = vim.tbl_deep_extend("force", {
--     capabilities = vim.deepcopy(capabilities),
--   }, opts.servers[server] or {})
--
--   if opts.setup[server] then
--     if opts.setup[server](server, server_opts) then
--       return
--     end
--   elseif opts.setup["*"] then
--     if opts.setup["*"](server, server_opts) then
--       return
--     end
--   end
--   lspconfig[server].setup(server_opts)
-- end
--
-- -- local ensure_installed = {} ---@type string[]
-- for server, server_opts in pairs(opts.servers) do
--   server_opts = server_opts == true and {} or server_opts
--   setup_server(server)
-- end

-- for server, server_opts in pairs(opts.servers) do
--   -- passing config.capabilities to blink.cmp merges with the capabilities in your
--   -- `opts[server].capabilities, if you've defined it
--   server_opts.capabilities = require('blink.cmp').get_lsp_capabilities(server_opts.capabilities)
--   lspconfig[server].setup(server_opts)
-- end
-- if opts.inlay_hints.enabled then
--   vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
-- end
--
-- -- code lens
-- if opts.codelens.enabled and vim.lsp.codelens then
--   vim.lsp.codelens.refresh()
--   vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
--     buffer = buffer,
--     callback = vim.lsp.codelens.refresh,
--   })
-- end

------------------------------------------------------------
-- Package-specific setup
------------------------------------------------------------
-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │  Portable package manager for Neovim that runs everywhere Neovim         │
-- │  runs.                                                                   │
-- ╰──────────────────────────────────────────────────────────────────────────╯
require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = false,
})
