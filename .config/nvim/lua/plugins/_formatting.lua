require("conform").setup({
  formatters_by_ft = {
    cpp = { 'clang-tidy', },
    fish = { "fish_indent", "typos" },
    git = { "typos", },
    html = { "typos", },
    javascript = { "dprint", "typos" },
    lua = { "stylua", "typos" },
    markdown = { "dprint", "typos" },
    python = { "ruff_format", "typos" },
    ruby = { "rubocop", "typos" },
    rust = { "rustfmt", "typos" },
    text = { "typos" },
    toml = { "typos", },
    typescript = { "typos", },
    yaml = { "typos" },
    zsh = { "typos" }
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
