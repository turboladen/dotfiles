# Formatting Setup Documentation

This document describes how to complete the formatting setup with global configuration files.

## Overview

The formatting system uses a hybrid approach:

- **LSP formatting** for languages where it excels (Rust, TOML, Python, Ruby)
- **External formatters** for languages where they're superior (Lua, Markdown, JSON, YAML, Shell
  scripts, etc.)

## Formatter Strategy by Language

### LSP Formatting (Auto-format on save)

| Language | Tool          | Config Location  | Notes                            |
| -------- | ------------- | ---------------- | -------------------------------- |
| Rust     | rust-analyzer | `./rustfmt.toml` | LSP calls rustfmt internally     |
| TOML     | taplo LSP     | `./taplo.toml`   | LSP includes formatting          |
| Python   | ruff LSP      | `pyproject.toml` | LSP handles formatting + linting |
| Ruby     | ruby-lsp      | `.rubocop.yml`   | LSP uses rubocop if available    |

### External Formatting (Auto-format on save)

| Language            | Tool     | Config Location      | Notes                               |
| ------------------- | -------- | -------------------- | ----------------------------------- |
| Lua                 | stylua   | `./stylua.toml`      | Project-only (superior to lua_ls)   |
| Markdown            | dprint   | `./dprint.json`      | Project-only (superior to marksman) |
| JSON                | dprint   | `./dprint.json`      | Project-only (superior to jsonls)   |
| YAML                | yamlfmt  | `~/.config/yamlfmt/` | Global config                       |
| Shell (sh/bash/zsh) | shfmt    | Built-in config      | Always available                    |
| TypeScript/JS       | dprint   | `./dprint.json`      | Project-only                        |
| SQL                 | sqlfluff | Built-in config      | Always available                    |

## Usage

### Keymaps

- `<leader>=` or `<leader>cf` - Format with external formatter (conform.nvim)
- `<leader>lf` - Format with LSP (for Rust, TOML, Python, Ruby)

### Commands

- `:ConformInfo` - Check formatter status
- `:FormatDisable` - Disable auto-format for current buffer
- `:FormatDisable!` - Disable auto-format globally
- `:FormatEnable` - Re-enable auto-format

### Format-on-Save

- **Enabled by default** for all configured languages
- **Intelligent routing**: Uses LSP for some languages, external formatters for others
- **Project-aware**: External formatters only run if config files exist
- **No conflicts**: LSP and external formatters are used for different languages

### Auto-Format Behavior

- **LSP languages** (Rust, TOML, Python, Ruby): Use `lsp_format = "prefer"`
- **External formatter languages** (Lua, Markdown, JSON, etc.): Use `lsp_format = "never"`

## Troubleshooting

### Formatter not running?

1. Check if the tool is installed: `which dprint`, `which stylua`, etc.
2. For project-specific formatters, ensure config file exists in project root
3. Use `:ConformInfo` to see formatter status
4. Check if formatting is disabled: `:FormatEnable`

### Conflicts between LSP and external formatters?

This setup avoids conflicts by design:

- **Clear language separation**: LSP formatting for some languages, external for others
- **Disabled conflicting LSP formatting**: marksman and bash-language-server formatting disabled
- **Different keymaps**: `<leader>=` (external) vs `<leader>lf` (LSP)
- **Smart format-on-save**: Uses the best formatter for each language automatically

### Want to change formatter strategy?

1. **Switch from external to LSP**: Remove language from `formatters_by_ft` in the lang file and
   move it to the `lsp_format_languages` list in `plugins/formatting.lua`
2. **Switch from LSP to external**: Add formatter config to the lang file and remove from
   `lsp_format_languages` list

### Required Dependencies

```bash
# Core formatters
curl -fsSL https://dprint.dev/install.sh | sh                    # markdown, json, js/ts
cargo install stylua                                             # lua
go install github.com/google/yamlfmt/cmd/yamlfmt@latest          # yaml
go install mvdan.cc/sh/v3/cmd/shfmt@latest                       # shell scripts
pip install ruff sqlfluff                                        # python, sql

# LSP servers (for languages using LSP formatting)
cargo install taplo-cli --locked --features lsp                  # toml
gem install ruby-lsp                                             # ruby
pip install ruff && npm install -g pyright                       # python
# rust-analyzer comes with rustaceanvim
```
