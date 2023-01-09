local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_extend("keep", capabilities, require("cmp_nvim_lsp").default_capabilities())
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

local function setup_lsp()
  local lsp_status = require("lsp-status")
  lsp_status.register_progress()

  local lspconfig = require("lspconfig")
  local capabilities = make_capabilities()

  require("turboladen.lsp.bashls").setup(lspconfig, capabilities)
  require("turboladen.lsp.clangd_extensions").setup(capabilities)
  require("turboladen.lsp.cmake").setup(lspconfig, capabilities)
  require("turboladen.lsp.deno").setup(lspconfig, capabilities)
  require("turboladen.lsp.dockerls").setup(lspconfig, capabilities)
  require("turboladen.lsp.efm").setup(lspconfig, capabilities)
  require("turboladen.lsp.emmet_ls").setup(lspconfig, capabilities)
  require("turboladen.lsp.eslint").setup(lspconfig, capabilities)
  require("turboladen.lsp.html").setup(lspconfig, capabilities)
  require("turboladen.lsp.jsonls").setup(lspconfig, capabilities)
  require("turboladen.lsp.prosemd_lsp").setup(lspconfig, capabilities)
  -- require("turboladen.lsp.ruby_analyzer").setup(lspconfig, capabilities)
  require("turboladen.lsp.solargraph").setup(lspconfig, capabilities)
  require("turboladen.lsp.steep").setup(lspconfig, capabilities)
  require("turboladen.lsp.sumneko_lua").setup(lspconfig, capabilities)
  require("turboladen.lsp.taplo").setup(lspconfig, capabilities)
  require("turboladen.lsp.terraformls").setup(lspconfig, capabilities)
  require("turboladen.lsp.tsserver").setup(lspconfig, capabilities)
  -- require("turboladen.lsp.typeprof").setup(lspconfig, capabilities)
  require("turboladen.lsp.vimls").setup(lspconfig, capabilities)
  require("turboladen.lsp.yamlls").setup(lspconfig, capabilities)

  lspconfig.tilt_ls.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").with_formatting,
    filetypes = { "tiltfile", "bzn" }
  })
  lspconfig.marksman.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
  lspconfig.zk.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
  })
  lspconfig.asm_lsp.setup({
    capabilities = capabilities,
    on_attach = require("turboladen.lsp.make_on_attach").for_any,
    filetypes = { "asm", "nasm", "vmasm" },
    root_dir = function()
      return "./"
    end
  })

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
    ["neotest"] = {
      log_level = vim.log.levels.ERROR
    }
  })

  vim.cmd([[
  set signcolumn=yes
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
  ]])
end

return {
  hover = hover,
  make_capabilities = make_capabilities,
  make_flags = make_flags,
  setup_lsp = setup_lsp,
}
