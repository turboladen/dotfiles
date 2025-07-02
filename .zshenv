# ╭─────────────────────────────────────────────────────────────────────────╮
# │ This file is _always_ sourced; ~/.zshrc is only sourced for interactive │
# │ sessions. Keep dev tools here so nvim spawned processes can access them │
# ╰─────────────────────────────────────────────────────────────────────────╯

# ╭─────────────────────────────────────────╮
# │ Environment variables for all processes │
# ╰─────────────────────────────────────────╯
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

# ╭─────────────────────────────────────────────────────────────────────╮
# │ PATH modifications (essential for nvim and spawned processes)      │
# ╰─────────────────────────────────────────────────────────────────────╯
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Application Support/fnm:$PATH"
export PATH="$PATH:~/.local/share/nvim/mason/bin"
export PATH="$PATH:/opt/homebrew/opt/llvm/bin"

# ╭─────────────────────────────────╮
# │ Android Studio for React Native │
# ╰─────────────────────────────────╯
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_NDK_ROOT=$HOME/Library/Android/sdk/ndk
export NDK_HOME=$HOME/Library/Android/sdk/ndk

# ╭────────────────────────────────────────────────────────────────╮
# │ Tool initialization (needed for all shells including nvim)    │
# ╰────────────────────────────────────────────────────────────────╯
source "$HOME/.cargo/env"
source "$HOME/.config/zsh/chruby.zsh"
chruby 3
eval "$(fnm env --use-on-cd)"
