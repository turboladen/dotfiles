-- Dependencies to install:
-- tilt: brew install tilt (includes tilt_ls via `tilt lsp start`)
-- buildifier: go install github.com/bazelbuild/buildtools/buildifier@latest (for starlark formatting/linting)

return {
  -- Treesitter Starlark parser (used for Tiltfiles)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "starlark" },
    },
    init = function()
      -- Map tiltfile filetype to starlark parser for syntax highlighting
      vim.treesitter.language.register("starlark", "tiltfile")
    end,
  },

  -- Tiltfile LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure tilt_ls (uses lspconfig defaults)
      vim.lsp.config("tilt_ls", {})

      vim.lsp.enable("tilt_ls")
    end,
  },

  -- Tiltfile linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.tiltfile = { "buildifier" }
      opts.linters_by_ft.starlark = { "buildifier" }
      return opts
    end,
  },
}
