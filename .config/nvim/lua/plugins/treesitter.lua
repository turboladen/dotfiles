--         ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--         ┃   Treesitter configurations and abstraction layer for    ┃
--         ┃                         Neovim.                          ┃
--         ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "angular",
    "asm",
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "comment",
    "cpp",
    "css",
    "csv",
    "cuda",
    "diff",
    "dockerfile",
    "dot",
    "editorconfig",
    "eex",
    "elixir",
    "embedded_template",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "gleam",
    "graphql",
    "hcl",
    "helm",
    "html",
    "http",
    "ini",
    "java",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "jsonnet",
    "just",
    "kotlin",
    "lalrpop",
    "latex",
    "llvm",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "nix",
    "objc",
    "ocaml",
    "passwd",
    "php",
    "phpdoc",
    "requirements", -- pip_requirements
    "proto",
    "python",
    "regex",
    "ron",
    "ruby",
    "rust",
    "scala",
    "scss",
    "sql",
    "ssh_config",
    "starlark",
    "swift",
    "terraform",
    "tmux",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "ungrammar",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "zig"
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  indent = {
    enable = true,
    -- disable = { "ruby" },
  },
})

--  ╭─────────────────────────────────────────────────────────────────╮
--  │ Location and syntax aware text objects which *do what you mean* │
--  ╰─────────────────────────────────────────────────────────────────╯
-- "RRethy/nvim-treesitter-textsubjects"
require('nvim-treesitter.configs').setup({
  enable = true,
  prev_selection = ',',
  keymaps = {
    ['.'] = 'textsubjects-smart',
    [';'] = 'textsubjects-container-outer',
    ['i;'] = 'textsubjects-container-inner',
  }
})

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99
