-- Dependencies to install:
-- dotenv-linter: brew install dotenv-linter

return {
  -- Run dotenv-linter only on .env files (which Neovim detects as sh filetype)
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        pattern = { ".env", ".env.*", "*.env" },
        callback = function()
          require("lint").try_lint("dotenv_linter")
        end,
      })
      return opts
    end,
  },
}
