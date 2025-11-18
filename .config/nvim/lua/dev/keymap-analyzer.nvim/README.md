# keymap-analyzer.nvim

A Neovim plugin for analyzing keymap conflicts and duplicates across your configuration.

## Features

- 🔍 **Duplicate Detection** - Find keymap conflicts across all config files
- 📊 **Statistics** - Get overview of your keymap usage
- 🎯 **Smart Navigation** - Jump directly to keymap definitions
- 📋 **Quickfix Integration** - Send results to quickfix for easy navigation
- 🚀 **Multiple Display Options** - FZF-Lua integration with extensible display system

## Installation

### With lazy.nvim

```lua
{
  "turboladen/keymap-analyzer.nvim",
  dependencies = {
    "ibhagwan/fzf-lua", -- For display functionality
  },
  keys = {
    { "<leader>pk", function() require("keymap-analyzer.fzf").show_duplicates() end, desc = "Check keymap duplicates" },
    { "<leader>pK", function() require("keymap-analyzer.fzf").show_all() end, desc = "Show all keymaps" },
    { "<leader>ps", function() require("keymap-analyzer.fzf").show_stats() end, desc = "Keymap statistics" },
  },
  config = function()
    vim.api.nvim_create_user_command("KeymapDuplicates", function()
      require("keymap-analyzer.fzf").show_duplicates()
    end, { desc = "Find duplicate keymaps" })

    vim.api.nvim_create_user_command("KeymapAll", function()
      require("keymap-analyzer.fzf").show_all()
    end, { desc = "Show all keymaps" })

    vim.api.nvim_create_user_command("KeymapStats", function()
      require("keymap-analyzer.fzf").show_stats()
    end, { desc = "Show keymap statistics" })
  end,
}
```

## Usage

### Commands

- `:KeymapDuplicates` - Find and display duplicate keymaps
- `:KeymapAll` - Browse all keymaps in your config
- `:KeymapStats` - Show keymap statistics

### API

#### Core Functions

```lua
local analyzer = require("keymap-analyzer")

-- Get all keymaps with metadata
local all_keymaps = analyzer.get_all_keymaps()

-- Find only duplicate keymaps
local duplicates = analyzer.find_duplicates()

-- Get summary statistics
local stats = analyzer.get_duplicate_stats()

-- Get formatted duplicate details
local details = analyzer.get_duplicate_details()

-- Navigation helpers
analyzer.jump_to_keymap(filepath, line_number)
analyzer.send_to_quickfix(keymaps, title)
```

#### FZF-Lua Display

```lua
local fzf = require("keymap-analyzer.fzf")

-- Show duplicates in fzf-lua picker
fzf.show_duplicates()

-- Show all keymaps in fzf-lua picker
fzf.show_all()

-- Show statistics notification
fzf.show_stats()
```

## What It Detects

The plugin scans your entire Neovim configuration and detects:

- `vim.keymap.set()` calls
- Lazy.nvim `keys` table entries
- Local `map()` function calls (like in LSP configs)
- Which-key group definitions
- Maps in ftplugin files

## Architecture

### Core Module (`keymap-analyzer`)
- **Display-agnostic** - Pure data analysis functions
- **Extensible** - Easy to add new display methods
- **Fast** - Efficient file scanning and pattern matching

### Display Modules (`keymap-analyzer.fzf`)
- **Modular** - Separate display logic from analysis
- **Pluggable** - Easy to create new display adapters
- **Feature-rich** - Jump to definition, quickfix integration

## Requirements

- Neovim 0.11+
- fzf-lua (for FZF display functionality)

## License

MIT
