return {
  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ -- Space Age seD in Neovim. A project-wide find and replace plugin       │
  -- │ for Neovim.                                                              │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  -- use({
  --   "ray-x/sad.nvim",
  --   dependencies = { "ray-x/guihua.lua" },
  --   config = function()
  --     require("sad").setup({})
  --   end
  -- })
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.register({
        ["<leader>b"] = {
          name = "Boxes and lines",
          b = {
            function()
              require("comment-box").albox()
              vim.lsp.buf.format({ async = false })
            end,
            "stuff"
          },
          t = {
            TurboladenCcBox,
            "Title box"
          }
        }
      })
    end
  },
}
