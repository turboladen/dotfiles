local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  capabilities = vim.tbl_extend("keep", capabilities, require("lsp-status").capabilities)

  return capabilities
end

local function hover()
  local filetype = vim.bo.filetype

  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  else
    vim.lsp.buf.hover()
  end
end

local function make_flags()
  return {
    debounce_text_changes = 350,
  }
end

-- local function make_lua_cmd()
--   -- brew install lua-language-server
--   local sumneko_binary = require("turboladen/homebrew").prefix() .. "/bin/lua-language-server"

--   return { sumneko_binary }
-- end

local function make_lua_settings()
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local runtime_files = vim.api.nvim_get_runtime_file("", true)
  vim.tbl_extend("keep", runtime_files, {
    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
  })

  return {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false
      }
    },
  }
end

local function setup_lsp()
  local lsp_status = require("lsp-status")
  lsp_status.register_progress()

  local lspconfig = require("lspconfig")
  local capabilities = make_capabilities()
  local flags = make_flags()

  lspconfig.solargraph.setup({
    init_options = {
      documentFormatting = true
    },
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    flags = flags
  })

  -- lspconfig.steep.setup({
  --   capabilities = capabilities,
  --   on_attach = make_on_attach("steep"),
  --   flags = flags
  -- })

  -- lspconfig.clangd.setup({
  --	capabilities = capabilities,
  --	on_attach = make_on_attach("clangd"),
  -- })
  require("clangd_extensions").setup({
    server = {
      capabilities = capabilities,
      on_attach = require("turboladen.lsp.make_on_attach").for_any,
      flags = flags,
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

  lspconfig.sumneko_lua.setup({
    -- cmd = make_lua_cmd(),
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    flags = flags,
    settings = make_lua_settings(),
  })

  -- pip install cmake-language-server
  -- https://github.com/regen100/cmake-language-server
  lspconfig.cmake.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })

  -- npm install -g dockerfile-language-server-nodejs
  -- https://github.com/rcjsuen/dockerfile-language-server-nodejs
  lspconfig.dockerls.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })

  -- lspconfig.ember.setup({
  --   capabilities = capabilities,
  --   on_attach = make_on_attach("ember"),
  --   flags = flags
  -- })

  -- lspconfig.tsserver.setup({
  --   capabilities = capabilities,
  --   on_attach = make_on_attach("tsserver"),
  --   flags = flags
  -- })
  lspconfig.denols.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    flags = flags
  })

  -- npm i -g vscode-langservers-extracted
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  local html_capabilities = capabilities
  html_capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.html.setup({
    capabilities = html_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
  local json_capabilities = capabilities
  json_capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.jsonls.setup({
    capabilities = json_capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })

  -- cargo install taplo-cli
  lspconfig.taplo.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })

  -- gem install typeprof
  -- lspconfig.typeprof.setup({
  --   capabilities = capabilities,
  --   on_attach = make_on_attach("typeprof"),
  --   flags = flags,
  -- })

  -- npm install -g vim-language-server
  -- https://github.com/iamcco/vim-language-server
  lspconfig.vimls.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })

  -- yarn global add yaml-language-server
  -- https://github.com/redhat-developer/yaml-language-server
  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    settings = {
      yaml = {
        schemaStore = {
          enable = true
        }
      },
    }
  })

  -- brew install efm-langserver
  -- https://github.com/mattn/efm-langserver
  lspconfig.efm.setup({
    init_options = {
      documentFormatting = true
    },
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    filetypes = {
      "bash",
      "markdown",
      "sh",
      "text",
      "zsh",
    }
  })

  -- local configs = require('lspconfig.configs')

  -- configs.meowtown = {
  --   default_config = {
  --     name = "meowtown";
  --     cmd = { '/Users/steve.loveless/Development/projects/meowtown/target/release/meowtown' };
  --     filetypes = { "ruby" };
  --     root_dir = function(fname)
  --       return lspconfig.util.find_git_ancestor(fname)
  --     end;
  --   };
  -- }

  -- lspconfig.meowtown.setup({
  --   capabilities = capabilities,
  --   on_attach = make_on_attach("meowtown"),
  -- })

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = true,
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
  })

  vim.cmd([[
  set signcolumn=yes
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
  ]])
end

return {
  hover = hover,
  make_capabilities = make_capabilities,
  make_on_attach = make_on_attach,
  make_flags = make_flags,
  setup_lsp = setup_lsp,
}
