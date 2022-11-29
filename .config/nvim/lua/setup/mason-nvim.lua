require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "bashls",
    "cmake",
    -- "denols",
    "dockerls",
    "efm", -- general purpose LS
    "emmet_ls", -- HTML fanciness
    "eslint",
    "jsonls",
    "prosemd_lsp",
    "rust_analyzer",
    "solargraph",
    "sumneko_lua",
    "taplo", -- TOML
    "terraformls",
    "tsserver",
    "vimls",
    "yamlls",
    "zk", -- zk notes, markdown
  }
})
