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

- `FORMATTING_SETUP.md` gives an overview of tools used for formatting code.
