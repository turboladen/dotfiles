--  ╭────────────────────────────────────╮
--  │ 💥 Create key bindings that stick. │
--  ╰────────────────────────────────────╯

local wk = require("which-key")

wk.setup({
  plugins = {
    -- spelling = true,
    presets = {
      windows = false,
      nav = false
    }
  },
})

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
