-- ╭───────────────────────────────────────────────────────────────────╮
-- │ For neovim, make sure to check config for mfussenegger/nvim-lint, │
-- │ since there can end up being overlap with this tool.              │
-- ╰───────────────────────────────────────────────────────────────────╯
local Plugin = { 'mfussenegger/nvim-lint' }

Plugin.event = "VeryLazy"

Plugin.config = function()
  require('lint').linters_by_ft = {
    c = {
      'clang-tidy',
    },
    cpp = {
      'clang-tidy',
    },
    cmake = {
      "cmakelint",
      "typos",
    },
    dockerfile = {
      "typos",
    },
    dotenv = {
      "dotenv_linter",
    },
    fish = {
      "fish",
    },
    git = {
      "typos",
    },
    html = {
      "typos",
    },
    javascript = {
      "typos",
    },
    lua = {
      "typos",
    },
    markdown = {
      'vale',
      "typos",
      "alex",
    },
    ruby = {
      "ruby",
      "typos",
    },
    rust = {
      "typos",
    },
    text = {
      "typos",
      "vale",
      "alex",
    },
    toml = {
      "typos",
    },
    typescript = {
      "typos",
    },
    yaml = {
      "typos",
      "yamllint",
    },
    zsh = {
      "typos",
      "zsh",
    }
  }

  require("user.commands").lint()
end

return Plugin
