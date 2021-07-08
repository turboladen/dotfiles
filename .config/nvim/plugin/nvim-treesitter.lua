-------------------------
-- nvim-treesitter
-------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "rust",
    "ruby",
    "toml",
    "typescript",
    "yaml"
  },

  highlight = {
    enable = true
  },
}
