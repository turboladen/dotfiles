local Plugin = { 'echasnovski/mini.nvim' }

Plugin.version = false

Plugin.config = function()
  require("mini.basics").setup()
  require("mini.bracketed").setup()
  require("mini.comment").setup()
  require("mini.cursorword").setup()
  require("mini.indentscope").setup({
    symbol = "│",
    options = { try_as_border = true },
  })
  -- require("mini.pairs").setup()
  -- require("mini.sessions").setup({
  --   autoread = true
  -- })

  -- require("mini.completion").setup()
  -- vim.keymap.set('i', '<C-j>', [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { expr = true })
  -- vim.keymap.set('i', '<C-k>', [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true })
end

Plugin.init = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "Trouble",
      "help",
      "lazy",
      "lazyterm",
      "mason",
      "notify",
      "ruby",
      "rust",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

return Plugin
