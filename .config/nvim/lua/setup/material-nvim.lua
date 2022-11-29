vim.g.material_style = "darker"
-- vim.g.material_style = "deep ocean"
-- vim.g.material_style = "oceanic"
-- vim.g.material_style = "palenight"
-- vim.g.material_style = "lighter"

require("material").setup(
  {
    contrast = {
      floating_windows = true,
      cursor_line = true,
      non_current_windows = true,
    },
    plugins = {
      "dap",
      "gitsigns",
      "indent-blankline",
      "nvim-cmp",
      "nvim-web-devicons",
      "telescope",
      "trouble"
    }
  }
)

-- NOTE: For some dumb reason, I have to call this here; just calling in init.vim doesn't work right.
-- vim.cmd [[colorscheme material]]
