# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Your Role

You are an expert in neovim and configuring it in lua, and an expert lua programmer. Your job is to
help me keep my configuration files in a logical, organized fashion, similar to the LazyVim
distribution. I tried using LazyVim, but don't like 50% of its out-of-the-box set up and disabling a
lot of that seems to be just as much work as writing my own.

## Tools

I'll use the `lazy.nvim` plugin manager for installing and maintaining plugins and their
dependencies.

I'm currently on neovim 0.11.2. Don't maintain backward compatibility with anything older than 0.11.

## Key Concerns

In no particular order:

- I think I like to keep things simple (KISS)
- I like to keep things DRY (don't repeat yourself)
- I want a logical organization system
- I'm interested in performant plugins and configuration
- I want to avoid configuration hassles
- I want to avoid duplicating keymaps (this is a common problem I've experienced over the years),
  but also make it very clear where keymaps are defined so it's easy to tell if I've created
  duplicates. In fact, it'd be nice to create a function that tells me if I've done this!
- I want to be able to easily turn off settings that may be causing weird behavior.
- I tend to prefer Rust-based plugins, if possible.
- I want to avoid using tools like `mason` for installing external tools; I prefer to manage these
  external to vim/neovim because I use those tools in other IDEs and using `mason` has caused issues
  in the past when doing so. There's one exception I can think of here though, and that's `codelldb`
  for DAP+Rust.
- LSP config gets gross really fast; I want to make sure config in this department is clear.
- Lots of plugins have integrations with other plugins; when setting up a new plugin that integrates
  with others, check this project to see if any of those exist.

## Architecture

### Boot Sequence

`init.lua` loads three modules in order:
1. `config.options` - vim options (no plugins)
2. `config.lazy` - bootstraps lazy.nvim, sets leaders (`<Space>` / `\`), loads plugin specs
3. `config.keymaps` - general keymaps not tied to any plugin

### Plugin Loading Strategy

`config/lazy.lua` builds its spec list by combining:
- `{ import = "plugins" }` - core plugin specs
- `{ import = "plugins.lang" }` - always-on language modules
- Output of `config.extras.get_enabled_extras()` - auto-discovered extras

**Extras auto-discovery**: `config/extras.lua` recursively scans `lua/plugins/extras/` at startup
and loads every `.lua` file it finds, unless explicitly disabled in `M.overrides`. To disable an
extra, add `["name"] = false` to the overrides table (e.g. `["lang.python"] = false`). The debug
function `require("config.extras").list_extras()` prints all available/enabled extras.

### Language Module Pattern

Each `lua/plugins/lang/*.lua` file is self-contained for its language, bundling:
1. Treesitter `ensure_installed` (extends the shared treesitter opts)
2. LSP server config via `vim.lsp.config()` + `vim.lsp.enable()`
3. Formatter config (extends `conform.nvim` opts with `optional = true`)
4. Linter config (extends `nvim-lint` opts)
5. A header comment listing external dependencies to install

Filetype-specific settings go in `after/ftplugin/<ft>.lua`. These should be **settings-only**
(indent, textwidth, commentstring, foldmethod) — not snippet/template insertion keymaps. The only
ftplugin keymaps should wrap actual plugin APIs (e.g. rustaceanvim in `rust.lua`, peek.nvim in
`markdown.lua`).

### Formatting Dual-Strategy

`plugins/formatting.lua` uses a split approach (documented fully in `FORMATTING_SETUP.md`):
- **LSP formatting** (`lsp_format = "prefer"`) for: Rust, TOML, Python, Ruby, Markdown, JSON, JS/TS
- **External formatters** (`lsp_format = "never"`) for: Lua (stylua), YAML (dprint), Fish
  (fish_indent), Shell (shfmt)

Format-on-save can be disabled per-buffer (`:FormatDisable`) or globally (`:FormatDisable!`), and
re-enabled with `:FormatEnable`. The toggle uses `vim.b.disable_autoformat` / `vim.g.disable_autoformat`.

### Shared Icons

`config/icons.lua` exports icon tables (diagnostics, git, files, ui, lsp, debug, test) consumed by
lualine, gitsigns, and other plugins. Always use these instead of hardcoding icons.

### Dev Plugins

`lua/dev/` contains two local plugins with standard plugin directory layout:
- **keymap-analyzer.nvim** - Scans all config Lua files for keymap definitions, finds duplicates,
  shows via fzf-lua. Commands: `KeymapDuplicates`, `KeymapAll`, `KeymapStats`.
- **dependency-analyzer.nvim** - Detects external tools referenced in config (LSP servers,
  formatters, linters), checks if they're installed. Commands: `DepsCheck`, `DepsMissing`,
  `DepsInstall`, `DepsReport`.

Both are registered in `plugins/util.lua` with `dev = true` and explicit `dir` paths.

### Extending Shared Plugin Opts

Lang files and extras extend shared plugin config (treesitter, conform, nvim-lint) by returning
additional lazy.nvim specs for the same plugin with `opts` or `opts = function()`. For conform and
nvim-lint, use `optional = true` on the spec. For treesitter, use `opts = { ensure_installed = {...} }`
which lazy.nvim merges via `opts_extend`.

## Organization

### High Level

All standard vim/neovim directories are candidates. Be as conventional as possible when it makes
sense. Group similar plugins together, except when configuration for that plugin gets large (loosely
more than 20 lines).

- `init.lua`: Main entrypoint. Keep as minimal as possible.
- `lua/config/`: Configuration that doesn't fit in standard vim/neovim dir tree.
- `lua/config/icons.lua`: Diagnostics icons, etc. to be used across plugins.
- `lua/config/options.lua`: (neo)vim options.
- `lua/dev`: Custom, local, dev plugins that I make; could be released to public if I feel like it.
- `lua/plugins/`: Standard location for lua plugins/plugin groups.
- `snippets/`: `friendly-snippets` formatted custom snippets.

### Config

`lua/config/` should only contain code that plays into setting up my config; mostly just `lazy.nvim`
and (neo)vim related configuration that's not necessarily tied to any plugins.

- `lua/config/extras.lua`: config for loading/skipping `plugins/extras/`.
- `lua/config/icons.lua`: icons that can/should be used across similar behavior across plugins.
- `lua/config/keymaps.lua`: general keymaps that don't belong to a plugin.
- `lua/config/lazy.lua`: `lazy.nvim` loading.
- `lua/config/options.lua`: Set neovim options.

### Local/Dev Plugins

On occasion, it might make sense to add some functionality which could be bundled up as my own
plugin. This code goes in `lua/dev/`. Code there should be clean, simple, and documented. This
directory should be laid out to handle multiple plugins.

### Plugins

#### Standard Plugins

`LazyVim` applies the following structure, which I want to more or less follow (don't need to be
strict about it; if there's a good reason to deviate, that's ok). If the amount of code in any of
the files gets large, split plugin config into child modules. Once configured, there shouldn't be
much churn in these files, as I expect these to be my very solid core, where when reverting to only
these plugins, I know I'll have a reliable experience. The areas are:

- `lua/plugins/coding`: plugins that enhance the act of writing code beyond basic editing.
- `lua/plugins/colorscheme`: Capture main schemes that I rotate. Also capture notes about different
  schemes & themes I've used over time.
  - When adding a new colorscheme, if the plugin has the capability to "dim inactive", turn that on.
- `lua/plugins/editor`: plugins that enhance the core text editing experience itself, regardless of
  when working with code or text.
- `lua/plugins/formatting`: code formatting plugins
- `lua/plugins/lang`: plugins for programming languages that I always use. It'd be nice to include
  _all_ setup for a language and all the plugins it requires in here. For example, `vim.lsp`
  settings, `nvim-lint` settings, etc.
  - When adding/updating be sure to:
    1. Ensure LSP settings are captured; don't duplicate settings that are provided by
       `nvim-lspconfig`.
    2. Ensure treesitter settings (ensure_installed) are captured
    3. Use `after/ftplugin` or other conventional (neo)vim directories as they should be used.
- `lua/plugins/linting`: linters and diagnostic tools
- `lua/plugins/lsp`: LSP plugins and config
- `lua/plugins/treesitter`: tree-sitter, related plugins, and config. Language-specific settings
  should go in `lang` files.
- `lua/plugins/ui`: UI enhancements like statuslines, file explorers, notification systems, and
  visual improvements.
- `lua/plugins/util` Utility libs and helpers that other plugins depend on.

#### Extras

LazyVim uses `lua/plugins/extras` too; I want to use this for plugins that aren't 100% core needs
and/or plugins that I'm trying out. These should be easy to disable if I run into configuration
issues. I do anticipate to follow some of these:

- `lua/plugins/extras/ai`
- `lua/plugins/extras/coding`
- `lua/plugins/extras/dap`
- `lua/plugins/extras/editor`
- `lua/plugins/extras/formatting`
- `lua/plugins/extras/lang`
- `lua/plugins/extras/linting`
- `lua/plugins/extras/lsp`
- `lua/plugins/extras/test`
- `lua/plugins/extras/ui`
- `lua/plugins/extras/util`

### Keymap Conventions

- Plugin-specific keymaps are defined in the plugin's lazy.nvim `keys` table or in `config` function
- LSP keymaps are defined centrally in `plugins/lsp.lua` via `LspAttach` autocmd, prefixed `LSP: `
- Filetype-specific keymaps go in `after/ftplugin/<ft>.lua` — only for wrapping plugin APIs (e.g.
  rustaceanvim in `rust.lua`, peek.nvim in `markdown.lua`). Do NOT add template/snippet insertion
  keymaps to ftplugin files.
- Leader groups are documented in which-key spec in `plugins/editor.lua`
- Use the keymap-analyzer dev plugin (`<leader>pk`) to check for duplicates
- `<leader>l` is reserved for LSP operations only — do not overload with other purposes
- `<leader>r` is for Rust (rustaceanvim) operations
- `<leader>=` is the sole format keymap (do not duplicate)
- `<leader>cl` triggers manual linting
- `<leader>.` opens `:Rg` for ripgrep-to-quickfix search
- `]]`/`[[` are owned by treesitter textobjects (class navigation), not vim-illuminate

### LSP Configuration Pattern

This config uses neovim 0.11's native `vim.lsp.config()` + `vim.lsp.enable()` (not the older
`lspconfig.server.setup()` pattern). Global LSP defaults (capabilities, blink.cmp integration) are
set once in `plugins/lsp.lua` via `vim.lsp.config("*", ...)`. Individual server configs live in
their respective `lang/*.lua` files.

- `FORMATTING_SETUP.md` gives an overview of tools used for formatting code.

### Auto-Pairs

Uses `mini.pairs` (not blink.pairs or nvim-autopairs). Chosen because it uses `<expr>` mappings
that flow through Neovim's typeahead buffer, so Vim's `.` repeat correctly replays the full bracket
pair. Binary/FFI-based auto-pair plugins (like blink.pairs) break `.` repeat because they insert
the closing bracket via API calls outside the typeahead.

Rainbow bracket highlighting is provided separately by `rainbow-delimiters.nvim`.

### Ripgrep Integration

`:Rg <pattern> [path ...]` is a custom user command in `config/keymaps.lua` that runs
`rg --vimgrep` and populates the quickfix list directly (no fzf picker). Mirrors rg CLI usage.
`<leader>.` opens the `:Rg` command prompt. fzf-lua's `<leader>/` (live grep) is still available
for interactive searching.

### Avoided Plugins

- **mason.nvim** — external tools managed outside Neovim (see Key Concerns)
- **vim-ripgrep** — replaced by custom `:Rg` command (simpler, no plugin dependency)
- **vim-unimpaired** — all bracket mappings are provided by purpose-built plugins (gitsigns,
  todo-comments, trouble.nvim, treesitter textobjects)
- **blink.pairs** — replaced by mini.pairs for `.` repeat support (see Auto-Pairs above)
