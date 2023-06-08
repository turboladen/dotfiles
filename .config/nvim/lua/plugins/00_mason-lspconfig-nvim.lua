-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │  Portable package manager for Neovim that runs everywhere Neovim         │
-- │  runs.                                                                   │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  "williamboman/mason-lspconfig.nvim",
  priority = 800,
  dependencies = {
    {
      {
        "williamboman/mason.nvim",
        build = 'MasonUpdate',
        opts = {},
      },
    },
    "neovim/nvim-lspconfig",
  },
  opts = {
    automatic_installation = false,
    ensure_installed = {
      -- "bashls",
      -- "cmake",
      -- "denols",
      -- "dockerls",
      "efm", -- general purpose LS
      -- "emmet_ls", -- HTML fanciness
      -- "eslint",
      "jsonls",
      "prosemd_lsp",
      -- "rust_analyzer",
      "solargraph",
      -- "lua_ls",
      -- "taplo", -- TOML
      -- "terraformls",
      -- "tsserver",
      -- "vimls",
      -- "yamlls",
      -- "zk", -- zk notes, markdown
    }
  }
}
