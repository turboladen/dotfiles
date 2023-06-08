-- ╭──────────────────────────────────────────────────────────────────────╮
-- │ 🚦 A pretty diagnostics, references, telescope results, quickfix and │
-- │ location list to help you solve all the trouble your code is causing.│
-- ╰──────────────────────────────────────────────────────────────────────╯

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Trouble", "TroubleRefresh", "TroubleToggle" },
  opts = {
    -- auto_preview = false,
    auto_close = true
  },
  config = function(_, opts)
    require("trouble").setup(opts)
  end
}
