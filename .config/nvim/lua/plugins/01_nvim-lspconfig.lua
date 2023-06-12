-- ╭─────────────────────────────────╮
-- │ Quickstart configs for Nvim LSP │
-- ╰─────────────────────────────────╯
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
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'K', require("turboladen.lsp").hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

      vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

      vim.keymap.set('n', '<leader>so', require("telescope.builtin").lsp_document_symbols, opts)
      vim.keymap.set('n', '<leader>sw', require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)


      -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<leader>ff', function()
        -- TODO: lspconfig uses true; my old config had false.
        vim.lsp.buf.format { async = true }
        -- vim.lsp.buf.format { async = false }
      end, opts)

      require("fidget").setup({})
    end,
  })
end

local function setup_regular_lsps(lsp_config, capabilities)
  -- Generic cases
  require("turboladen.lsp").setup_lsp("bashls", lsp_config, capabilities)
  require("turboladen.lsp").setup_lsp("cmake", lsp_config, capabilities)
  require("turboladen.lsp").setup_lsp("dockerls", lsp_config, capabilities)
  require("turboladen.lsp").setup_lsp("prosemd_lsp", lsp_config, capabilities)
  require("turboladen.lsp").setup_lsp("solargraph", lsp_config, capabilities) -- (Ruby)
  require("turboladen.lsp").setup_lsp("steep", lsp_config, capabilities)      -- (Ruby)
  require("turboladen.lsp").setup_lsp("taplo", lsp_config, capabilities)      -- (TOML)
  require("turboladen.lsp").setup_lsp("terraformls", lsp_config, capabilities)
  require("turboladen.lsp").setup_lsp("tsserver", lsp_config, capabilities)
  -- require("turboladen.lsp").setup_lsp("typeprof", lsp_config, capabilities) -- (Ruby)
  require("turboladen.lsp").setup_lsp("vimls", lsp_config, capabilities)

  -- Special cases
  require("plugins.lsp.clangd_extensions").setup(capabilities)
  require("plugins.lsp.deno").setup(lsp_config, capabilities)
  require("plugins.lsp.efm").setup(lsp_config, capabilities)
  require("plugins.lsp.emmet_ls").setup(lsp_config, capabilities)
  require("plugins.lsp.eslint").setup(lsp_config, capabilities)
  require("plugins.lsp.html").setup(lsp_config, capabilities)
  require("plugins.lsp.jsonls").setup(lsp_config, capabilities)
  require("plugins.lsp.lua_ls").setup(lsp_config, capabilities)
  -- require("plugins.lsp.ruby_analyzer").setup(lsp_config, capabilities)
  require("plugins.lsp.yamlls").setup(lsp_config, capabilities)
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
    -- Setting this to false turns off all the annoyin rust-analyzer long loop warnings
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
  "neovim/nvim-lspconfig",
  priority = 900,
  dependencies = {
    "p00f/clangd_extensions.nvim",
    "b0o/schemastore.nvim",
    { "j-hui/fidget.nvim", tag = "legacy" },
    "nvim-lua/lsp-status.nvim",
    "stevearc/aerial.nvim",
  },
  init = function()
    vim.opt.signcolumn = "yes"
  end,
  config = function()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    make_attach_things()

    local lsp_config = require("lspconfig")
    local capabilities = require("turboladen.lsp").make_capabilities()

    setup_regular_lsps(lsp_config, capabilities)

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                 Still trying these out.                  │
    --  ╰──────────────────────────────────────────────────────────╯
    -- lsp_config.tilt_ls.setup({
    --   capabilities = capabilities,
    --   filetypes = { "tiltfile", "bzn" }
    -- })
    -- lsp_config.marksman.setup({
    --   capabilities = capabilities,
    -- })
    require("turboladen.lsp").setup_lsp("pyright", lsp_config, capabilities)
    require("turboladen.lsp").setup_lsp("ruff_lsp", lsp_config, capabilities)
    require("turboladen.lsp").setup_lsp("gradle_ls", lsp_config, capabilities)
    -- require("turboladen.lsp").setup_lsp("ocamllsp", lsp_config, capabilities)

    -- lsp_config.asm_lsp.setup({
    --   capabilities = capabilities,
    --   filetypes = { "asm", "nasm", "vmasm" },
    --   root_dir = function()
    --     return "./"
    --   end
    -- })
    -- lsp_config.sourcekit.setup({
    --   -- cmd = { "xcrun", "sourcekit-lsp" },
    --   capabilities = capabilities,
    --   filetypes = { "swift", "c", "cpp", "objc", "objcpp", "objective-c", "objective-cpp" },
    --   root_dir = function()
    --     return "./"
    --   end,
    -- })

    configure_diagnostic_signs()
    set_diagnostic_config()

    -- NOTE: 07-jun-23. Commenting out for now since this would try to format all filetypes,
    -- even if it doesn't have an LSP.
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('lsp_formatting', {}),
      callback = function(ev)
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
}
