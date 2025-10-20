### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/steve.loveless/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# ╭──────────────────╮
# │ Homebrew Setup   │
# ╰──────────────────╯
# Initialize Homebrew environment variables and ensure paths come first
if test -f /opt/homebrew/bin/brew
    set --global --export HOMEBREW_PREFIX "/opt/homebrew"
    set --global --export HOMEBREW_CELLAR "/opt/homebrew/Cellar"
    set --global --export HOMEBREW_REPOSITORY "/opt/homebrew"
    # Use --move to avoid duplicates and --prepend to ensure Homebrew comes first
    fish_add_path --global --move --prepend /opt/homebrew/bin /opt/homebrew/sbin
end

# ╭─────────────────────╮
# │ Login Configuration │
# ╰─────────────────────╯
if status is-login
    set -gx EDITOR /opt/homebrew/bin/nvim
    # set -gx HOMEBREW_CASK_OPTS "--appdir=~/Applications"

    # Use bat as manpager for syntax highlighting
    set -gx MANPAGER sh\ -c\ \'col\ -bx\ \|\ bat\ -l\ man\ -p\'

    # FZF integration with bat for file previews
    set -gx FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always {}'"

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

    # Show system info on startup
    fastfetch
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
