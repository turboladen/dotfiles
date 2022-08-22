-- vim.g.material_style = "darker"
-- vim.g.material_style = "deep ocean"
vim.g.material_style = "oceanic"
-- vim.g.material_style = "palenight"
-- vim.g.material_style = "lighter"
require("material").setup(
  {
    borders = true,
    italics = {
      comments = false
    }
  }
)
-- vim.cmd [[colorscheme material]]
