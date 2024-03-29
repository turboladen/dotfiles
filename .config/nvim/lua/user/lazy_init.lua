--  ╭──────────────────╮
--  │ lazy.nvim things │
--  ╰──────────────────╯
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  dev = {
    path = "~/Development/projects/",
  },
  install = {
    colorscheme = { "nightfox" }
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "tarPlugin",
        "tutor",
        "zipPlugin"
      }
    }
  }
})
