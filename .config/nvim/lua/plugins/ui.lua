return {
  {
    "j-hui/fidget.nvim",
    -- Disabling because noice provides its own.
    enabled = false,
    tag = "v1.0.0",
    opts = {},
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Icon set using nonicons for neovim plugins and settings │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "yamatsum/nvim-nonicons",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
