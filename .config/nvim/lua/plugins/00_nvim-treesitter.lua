-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Treesitter configurations and abstraction layer for Neovim.              │
-- │                                                                          │
-- │ nvim-ts-rainbow: 🌈 Rainbow parentheses for neovim using tree-sitter 🌈  │
-- │ nvim-ts-context-commentstring: Neovim treesitter plugin for setting      │
-- │         the commentstring based on the cursor location in a file.        │
-- │ nvim-treesitter-context: Show code context                               │
-- │ commentary.vim: comment stuff out                                        │
-- ╰──────────────────────────────────────────────────────────────────────────╯

local opts = {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    -- "dockerfile",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "hcl",
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
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "tpope/vim-commentary", -- <- for ^^
    "andymass/vim-matchup",
    "nvim-treesitter/nvim-treesitter-context",
    "p00f/nvim-ts-rainbow",
  },
  opts = opts,
  config = function(_, options)
    require("nvim-treesitter.configs").setup(options)

    -- Treesitter folding
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.o.foldlevel = 99
  end
}
