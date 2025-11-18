### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/steve.loveless/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# ╭──────────────────╮
# │ Tool Paths       │
# ╰──────────────────╯
# Rust/Cargo
fish_add_path --path ~/.cargo/bin

# LLVM from Homebrew (if you use it)
fish_add_path --path /opt/homebrew/opt/llvm/bin

# ╭─────────────────────╮
# │ Login Configuration │
# ╰─────────────────────╯
if status is-login
    set --global --export EDITOR /opt/homebrew/bin/nvim
    # set -gx HOMEBREW_CASK_OPTS "--appdir=~/Applications"

    # Use bat as manpager for syntax highlighting
    set --global --export MANPAGER sh\ -c\ \'col\ -bx\ \|\ bat\ -l\ man\ -p\'

    # FZF integration with bat for file previews
    set --global --export FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always {}'"

    # Add Postgres.app to PATH
    fish_add_path ~/Applications/Postgres.app/Contents/Versions/latest/bin
    fish_add_path ~/Applications/Postgres.app/Contents/Versions/latest/lib
end

# ╭───────────────────────────╮
# │ Interactive Configuration │
# ╰───────────────────────────╯
if status is-interactive
    # Disable fish greeting
    set fish_greeting

    # Set up aliases
    alias .. 'cd ..'

    # Use vi key bindings
    fish_vi_key_bindings

    # tv init fish | source

    # Show system info on startup
    fastfetch
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Postgres.app
fish_add_path ~/Applications/Postgres.app/Contents/Versions/latest/bin
fish_add_path ~/Applications/Postgres.app/Contents/Versions/latest/lib

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
