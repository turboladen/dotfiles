-- ╭─────────────────────────────────────────╮
-- │ Neovim plugin for a code outline window │
-- ╰─────────────────────────────────────────╯
local aerial = require("aerial")

aerial.setup({
  filter_kind = false,
  on_attach = function(bufnr)
    require("which-key").add({
      { "<leader>ba", aerial.toggle,              desc = "aerial: Toggle symbols",     buffer = bufnr },
      { "<leader>bn", "<CMD>AerialNavToggle<CR>", desc = "aerial: Toggle nav symbols", buffer = bufnr },

      -- Jump forwards/backwards with '{' and '}'
      { "{",          aerial.prev,                desc = "aerial: Previous",           buffer = bufnr },
      { "}",          aerial.next,                desc = "aerial: Next",               buffer = bufnr },

      -- Jump up the tree with '[[' or ']]'
      { "[[",         aerial.prev_up,             desc = "aerial: Previous up",        buffer = bufnr },
      { "]]",         aerial.next_up,             desc = "aerial: Next up",            buffer = bufnr },
    })
  end,
  show_guides = true,
  layout = {
    resize_to_content = false,
    win_opts = {
      winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
      signcolumn = "yes",
      statuscolumn = " ",
    },
  },
})

require("todo-comments").setup({})

-- ╭────────────────────────────────╮
-- │ "vim-utils/vim-troll-stopper", │
-- ╰────────────────────────────────╯
vim.cmd([[highlight TrollStopper ctermbg = red guibg = #FF0000 ]])

-- ╭─────────────╮
-- │ vim-ripgrep │
-- ╰─────────────╯
vim.g.rg_command = "rg --vimgrep --ignore-vcs"

-- ╭────────────────────────────────────────────────────╮
-- │ Neovim plugin for splitting/joining blocks of code │
-- ╰────────────────────────────────────────────────────╯
require("treesj").setup({
  use_default_keymaps = false,
  max_join_length = 100,
})

-- require("user.commands").treesj()

-- local langs = require('treesj.langs')['presets']
--
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   group = vim.api.nvim_create_augroup('user_treesj_keymaps', { clear = true }),
--   pattern = '*',
--   callback = function()
--     require("user.keymaps").treesj(langs)
--   end
-- })
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

-- ╭──────────╮
-- │ gitsigns │
-- ╰──────────╯
require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
  on_attach = function(bufnr)
    require("user.keymaps").gitsigns(bufnr)
  end,
})

-- ╭──────────────────────────────────────────────────────────────────────╮
-- │ 🚦 A pretty diagnostics, references, telescope results, quickfix and │
-- │ location list to help you solve all the trouble your code is causing.│
-- ╰──────────────────────────────────────────────────────────────────────╯
require("trouble").setup({
  -- auto_preview = false,
  auto_close = true,
  use_diagnostic_signs = true
})
