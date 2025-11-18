-- Dependencies to install:
-- vscode-html-language-server: npm install -g vscode-langservers-extracted
-- htmlhint: npm install -g htmlhint

return {
  -- Treesitter HTML parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "html", "css", "javascript" },
    },
  },

  -- HTML LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure html LSP (uses lspconfig defaults with enhanced embedded languages)
      vim.lsp.config("html", {
        init_options = {
          provideFormatter = true,
          embeddedLanguages = { css = true, javascript = true },
          configurationSection = { "html", "css", "javascript" },
        },
      })

      vim.lsp.enable("html")
    end,
  },

  -- HTML linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.html = { "htmlhint" }
      return opts
    end,
  },
}
