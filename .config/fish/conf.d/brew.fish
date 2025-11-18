# ╭──────────────────╮
# │ Homebrew Setup   │
# ╰──────────────────╯
# Initialize Homebrew environment variables and ensure paths come first
if test -f /opt/homebrew/bin/brew
    set --global --export HOMEBREW_PREFIX /opt/homebrew
    set --global --export HOMEBREW_CELLAR /opt/homebrew/Cellar
    set --global --export HOMEBREW_REPOSITORY /opt/homebrew
    # Use --move to avoid duplicates and --prepend to ensure Homebrew comes first
    fish_add_path --global --move --prepend /opt/homebrew/bin /opt/homebrew/sbin
end
