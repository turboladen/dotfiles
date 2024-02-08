-- local function make_attach_things()
--   -- Use LspAttach autocommand to only map the following keys
--   -- after the language server attaches to the current buffer
--   vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--
--     callback = function(ev)
--       -- Enable completion triggered by <c-x><c-o>
--       vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--       -- Buffer local mappings.
--       -- See `:help vim.lsp.*` for documentation on any of the below functions
--       local function opts(desc)
--         return {
--           buffer = ev.buf,
--           desc = desc
--         }
--       end
--
--       require("which-key").register({
--         g = {
--           d = { vim.lsp.buf.definition, "Goto definition", buffer = ev.buf },
--           D = { vim.lsp.buf.declaration, "Goto declaration", buffer = ev.buf },
--           r = { vim.lsp.buf.references, "Goto references", buffer = ev.buf },
--           i = { vim.lsp.buf.implementation, "Goto implementation", buffer = ev.buf },
--         },
--
--         ["<leader>f"] = {
--           r = { "<cmd>Telescope lsp_references<cr>", "tele: references", buffer = ev.buf },
--           i = { "<cmd>Telescope lsp_implementations<cr>", "tele: implementations", buffer = ev.buf },
--         },
--
--         ["<leader>x"] = {
--           f = { vim.diagnostic.open_float, "Open diagnostic in float" },
--           i = { "<cmd>LspInfo<cr>", "LspInfo" },
--         }
--       })
--
--       -- vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts("Signature help"))
--       -- vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts("Signature help"))
--
--       -- vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts("Rename"))
--       -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts("Code action"))
--
--       -- vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts("Previous diagnostic"))
--       -- vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts("Next diagnostic"))
--       -- vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, opts("Add buffer diagnostics to loclist"))
--
--       -- vim.keymap.set('n', '<leader>co', require("telescope.builtin").lsp_document_symbols, opts("Show doc symbols"))
--       -- vim.keymap.set('n', '<leader>cw', require("telescope.builtin").lsp_dynamic_workspace_symbols,
--       --   opts("Show workspace symbols"))
--
--
--       -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--       -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--       --
--
--       -- vim.keymap.set('n', '<leader>ff', function()
--       --   -- TODO: lspconfig uses true; my old config had false.
--       --   vim.lsp.buf.format { async = true }
--       --   -- vim.lsp.buf.format { async = false }
--       -- end, opts("Format (vis LSP)"))
--       --
--       require("fidget").setup({})
--     end,
--   })
-- end


return {
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
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup(opts)
    end
  },

  -- ╭─────────────────────────────────╮
  -- │ Quickstart configs for Nvim LSP │
  -- ╰─────────────────────────────────╯
  {
    "onsails/lspkind-nvim",
    -- event = "LspAttach",
    event = "BufEnter",
    opts = {
      mode = "symbol"
    },
    config = function(_, opts)
      require("lspkind").init(opts)
    end
  }
}
