require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "hcl",
    "help",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "llvm",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "proto",
    "python",
    "regex",
    "ruby",
    "rust",
    "scss",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    -- disable = { "lua" },
  },
  incremental_selection = { enable = true },
  indent = {
    enable = true,
    disable = { "ruby" },
  },
  -- https://github.com/andymass/vim-matchup
  matchup = {
    enable = true,
    -- disable = { "rust" },
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
  context_commentstring = {
    enable = true,
    config = {
      rust = {
        __default = "// %s",
        comment = "// %s",
      },
    },
  },
})

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99
