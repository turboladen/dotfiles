--         ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--         ┃   Treesitter configurations and abstraction layer for    ┃
--         ┃                         Neovim.                          ┃
--         ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
local Plugin = { "nvim-treesitter/nvim-treesitter" }
Plugin.build = ":TSUpdate"

Plugin.event = { "BufReadPost", "BufNewFile" }
Plugin.dependencies = {
  require("plugins.nvim_ts_context_commentstring"),
  require("plugins.vim_commentary"),
  require("plugins.vim_matchup"),
  require("plugins.nvim_treesitter_context"),
  require("plugins.nvim_treesitter_textsubjects"),
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
    "dockerfile",
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
    "just",
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
  matchup = require("plugins.vim_matchup").treesitter_config,

  --  ╭─────────────────────────────────────────────╮
  --  │ JoosepAlviste/nvim-ts-context-commentstring │
  --  ╰─────────────────────────────────────────────╯
  -- NOTE: Commenting out because it seems like this call might not be needed?
  -- context_commentstring = require("plugins.nvim_ts_context_commentstring").treesitter_config,

  --  ╭─────────────────────────────────────╮
  --  │ RRethy/nvim-treesitter-textsubjects │
  --  ╰─────────────────────────────────────╯
  textsubjects = require("plugins.nvim_treesitter_textsubjects").treesitter_config
}

Plugin.config = function(opts)
  require("nvim-treesitter.configs").setup(opts)

  -- Treesitter folding
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.o.foldlevel = 99
end

return Plugin
