--  ╭────────────────────────────────────╮
--  │ 💥 Create key bindings that stick. │
--  ╰────────────────────────────────────╯
local Plugin = { "folke/which-key.nvim" }

Plugin.event = "VeryLazy"

-- Plugin.init = function()
--   vim.o.timeout = true
--   vim.o.timeoutlen = 300
-- end

Plugin.opts = {
  plugins = {
    -- spelling = true,
    presets = {
      windows = false,
      nav = false
    }
  },
}

Plugin.config = function(_, opts)
  local wk = require("which-key")
  wk.setup(opts)
  wk.add({
    { "g",         group = "+goto" },
    { "]",         group = "+next" },
    { "[",         group = "+prev" },

    -- ╭─────────────────╮
    -- │ <leader> things │
    -- ╰─────────────────╯
    -- { "<leader><tab>", group = "+tabs" },
    { "<leader>b", group = "+buffer" },
    { "<leader>c", group = "+code" },
    { "<leader>d", group = "+dap" },
    { "<leader>e", group = "+edit" },
    { "<leader>f", group = "+file/find" },
    { "<leader>g", group = "+git" },
    { "<leader>l", group = "+lsp" },
    { "<leader>p", group = "+packages" },
    { "<leader>r", group = "+rust" },
    { "<leader>t", group = "+test" },
    { "<leader>s", group = "+search" },
    { "<leader>u", group = "+ui" },
    { "<leader>w", group = "+windows" },
    { "<leader>x", group = "+diagnostics/quickfix" },
  }
  )
end


return Plugin
