# ╭─────────────────────────────────────────────────────────────────────────╮
# │ This file is _always_ sourced; ~/.zshrc is only sourced for interactive │
# │ sessions. Keep dev tools here so nvim spawned processes can access them │
# ╰─────────────────────────────────────────────────────────────────────────╯

# ╭──────────────╮
# │ Homebrew     │
# ╰──────────────╯
export HOMEBREW_PREFIX="$(brew --prefix)"

# ╭─────────────────────────────────────────────────────────────────────╮
# │ PATH modifications (essential for nvim and spawned processes)       │
# ╰─────────────────────────────────────────────────────────────────────╯
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/binutils/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# ╭────────────────────────────────────────────────────────────────╮
# │ Tool initialization (needed for all shells including nvim)    │
# ╰────────────────────────────────────────────────────────────────╯
# Cargo environment
source "$HOME/.cargo/env"

# chruby - load before fnm to ensure Ruby available everywhere
source "${HOMEBREW_PREFIX}/opt/chruby/share/chruby/chruby.sh"
source "${HOMEBREW_PREFIX}/opt/chruby/share/chruby/auto.sh"
chruby 3

# fnm - Fast Node Manager
eval "$(fnm env --use-on-cd)"

# ╭───────────────────────────────╮
# │ Environment-specific configs  │
# ╰───────────────────────────────╯
# Source all environment configs
if [[ -d "$HOME/.config/zsh/env" ]]; then
  for env_file in "$HOME/.config/zsh/env"/*.zsh; do
    [[ -f "$env_file" ]] && source "$env_file"
  done
fi
