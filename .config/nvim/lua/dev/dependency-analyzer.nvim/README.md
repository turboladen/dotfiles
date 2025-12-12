# dependency-analyzer.nvim

A Neovim plugin for dynamically analyzing external dependencies in your configuration.

## Features

- 🔍 **Dynamic Discovery** - Scans your config files to find actual dependencies
- 📊 **Installation Status** - Checks if tools are installed on your system
- 🛠️ **Smart Heuristics** - Uses patterns to identify external tools vs internal config
- 📋 **Multiple Display Options** - Summary notifications, detailed buffers, install scripts
- 🎯 **Loosely Coupled** - Core analysis separate from display logic

## What It Detects

The plugin scans your entire Neovim configuration and detects:

- **LSP servers** from `vim.lsp.config()`, `vim.lsp.enable()`, `lspconfig.*.setup()`
- **Formatters** from `formatters_by_ft` tables in conform.nvim config
- **Linters** from `linters_by_ft` tables in nvim-lint config
- **Manual entries** from "Dependencies to install:" comments in language files

## Usage

### Commands

- `:DepsCheck` - Quick notification with summary statistics
- `:DepsMissing` - Detailed view of missing dependencies in a markdown buffer
- `:DepsInstall` - Generate executable bash script to install missing tools
- `:DepsReport` - Complete analysis report in a new tab
- `:DepsData` - Raw JSON data for programmatic use

### API

#### Core Functions

```lua
local analyzer = require("dev.dependency-analyzer.nvim")

-- Get complete analysis data
local data = analyzer.get_data()

-- Get just missing tools
local missing = analyzer.get_missing_tools()

-- Get installed tools with versions
local installed = analyzer.get_installed_tools()

-- Get summary statistics
local summary = analyzer.get_summary()
```

#### Display Functions

```lua
local builtin = require("dependency-analyzer.builtin")

-- Show quick summary notification
builtin.show_summary()

-- Show missing tools in markdown buffer
builtin.show_missing()

-- Generate install script in bash buffer
builtin.show_install_commands()

-- Full report in new tab
builtin.show_full_report()
```

## How It Works

1. **File Scanning** - Recursively scans your `lua/plugins/` directory
2. **Pattern Matching** - Uses regex patterns to find tool references
3. **Heuristic Filtering** - Applies rules to distinguish external tools from config
4. **Installation Check** - Runs `which` and `--version` commands to verify installation
5. **Comment Parsing** - Extracts install commands from dependency comments

## Architecture

### Core Module (`dev.dependency-analyzer.nvim`)

- **Display-agnostic** - Pure data analysis functions
- **Extensible** - Easy to add new detection patterns
- **Fast** - Efficient file scanning and tool checking

### Display Module (`dependency-analyzer.builtin`)

- **Built-in UI** - Uses Neovim's native features (buffers, notifications)
- **Multiple Views** - Summary, detailed, install script, full report
- **Copy-friendly** - Install commands in executable format

## Requirements

- Neovim 0.11+
- Standard Unix tools (`which`, shell access for version checking)

## Configuration Files Scanned

- `lua/plugins/lang/*.lua`
- `lua/plugins/extras/lang/*.lua`
- `lua/plugins/formatting.lua`
- `lua/plugins/linting.lua`
- `lua/plugins/lsp.lua`

## Comment Format

Add dependency information to your language files:

```lua
-- Dependencies to install:
-- stylua: cargo install stylua
-- lua-language-server: brew install lua-language-server
-- Note: Additional notes about installation
```

## License

MIT
