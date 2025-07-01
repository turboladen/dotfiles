-- Dependencies to install:
-- marksman: brew install marksman
-- vale: brew install vale
-- alex: npm install -g alex

return {
  -- Treesitter Markdown parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "markdown", "markdown_inline" },
    },
  },

  -- Markdown LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure marksman LSP (uses lspconfig defaults)
      vim.lsp.config("marksman", {})

      vim.lsp.enable("marksman")
    end,
  },

  -- Markdown linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Add markdown linters to existing configuration
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = { "vale", "alex" }
      opts.linters_by_ft.md = { "vale", "alex" }
      return opts
    end,
  },

  -- Live markdown preview
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    ft = { "markdown", "md" },
    config = function()
      require("peek").setup({
        auto_load = true, -- auto load preview when entering markdown buffer
        close_on_bdelete = true, -- close preview when buffer is deleted
        syntax = true, -- enable syntax highlighting
        theme = "dark", -- 'dark' or 'light'
        update_on_change = true, -- update preview on buffer changes
        app = "webview", -- use webview for preview
        filetype = { "markdown" }, -- filetypes to recognize as markdown
        throttle_at = 200000, -- throttle updates for large files
        throttle_time = "auto", -- auto throttle timing
      })

      -- Create user commands for peek
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      vim.api.nvim_create_user_command("PeekToggle", function()
        local peek = require("peek")
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end, {})
    end,
  },
}
