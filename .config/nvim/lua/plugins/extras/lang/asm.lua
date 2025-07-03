-- Dependencies to install:
-- asm-lsp: cargo install asm-lsp

return {
  -- Treesitter Assembly parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "asm" },
    },
  },

  -- Assembly LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure asm-lsp with additional filetypes
      vim.lsp.config("asm_lsp", {
        filetypes = { "asm", "nasm", "vmasm" },
        root_dir = function()
          return "./"
        end,
      })

      vim.lsp.enable("asm_lsp")
    end,
  },
}
