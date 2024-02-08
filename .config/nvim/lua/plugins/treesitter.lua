--         ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--         ┃   Treesitter configurations and abstraction layer for    ┃
--         ┃                         Neovim.                          ┃
--         ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.build = ":TSUpdate"

Plugin.event = { "BufReadPost", "BufNewFile" }
Plugin.dependencies = {
  --  ╭─────────────────────────────────────────────────────────────────────────╮
  --  │ nvim-ts-context-commentstring: Neovim treesitter plugin for setting the │
  --  │ commentstring based on the cursor location in a file.                   │
  --  ╰─────────────────────────────────────────────────────────────────────────╯
  -- "JoosepAlviste/nvim-ts-context-commentstring",
  "tpope/vim-commentary", -- <- for ^^
  "andymass/vim-matchup",
  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ Lightweight alternative to context.vim implemented with nvim-treesitter. │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  "nvim-treesitter/nvim-treesitter-context",
  --  ╭─────────────────────────────────────────────────────────────────────────╮
  --  │ nvim-ts-rainbow: 🌈 Rainbow parentheses for neovim using tree-sitter 🌈 │
  --  ╰─────────────────────────────────────────────────────────────────────────╯
  "p00f/nvim-ts-rainbow",
  --  ╭─────────────────────────────────────────────────────────────────╮
  --  │ Location and syntax aware text objects which *do what you mean* │
  --  ╰─────────────────────────────────────────────────────────────────╯
  {
    "RRethy/nvim-treesitter-textsubjects",
    lazy = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}

Plugin.opts = {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "diff",
    -- "dockerfile",
    "eex",
    "elixir",
    "embedded_template",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "graphql",
    "hcl",
    "html",
    "http",
    "ini",
    "javascript",
    "java",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    -- "just",
    "kotlin",
    "lalrpop",
    "llvm",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "objc",
    "ocaml",
    "passwd",
    "php",
    "phpdoc",
    "proto",
    "python",
    "regex",
    "ron",
    "ruby",
    "rust",
    "scala",
    "scss",
    "sql",
    "starlark",
    "swift",
    "terraform",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "ungrammar",
    "vim",
    "yaml",
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
  --  ╭─────────────────────────────────────────╮
  --  │ https://github.com/andymass/vim-matchup │
  --  ╰─────────────────────────────────────────╯
  matchup = {
    enable = true,
    -- disable = { "rust" },
  },
  --  ╭──────────────────────╮
  --  │ p00f/nvim-ts-rainbow │
  --  ╰──────────────────────╯
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
  --  ╭─────────────────────────────────────────────╮
  --  │ JoosepAlviste/nvim-ts-context-commentstring │
  --  ╰─────────────────────────────────────────────╯
  -- context_commentstring = {
  --   enable = true,
  --   config = {
  --     rust = {
  --       __default = "// %s",
  --       comment = "// %s",
  --     },
  --   },
  -- },
  --  ╭─────────────────────────────────────╮
  --  │ RRethy/nvim-treesitter-textsubjects │
  --  ╰─────────────────────────────────────╯
  textsubjects = {
    enable = true,
    prev_selection = ',',
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    }
  }
}

Plugin.config = function(opts)
  require("nvim-treesitter.configs").setup(opts)

  -- Treesitter folding
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.o.foldlevel = 99
end

return Plugin
