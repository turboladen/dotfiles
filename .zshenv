# ╭─────────────────────────────────────────────────────────────────────────╮
# │ This file is _always_ sourced; ~/.zshrc is only sourced for interactive │
# │                                sessions                                 │
# ╰─────────────────────────────────────────────────────────────────────────╯
eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

#  ╭──────╮
#  │ Rust │
#  ╰──────╯
PATH=$PATH:"$HOME/.cargo/bin"
source "$HOME/.cargo/env"

#  ╭──────╮
#  │ Ruby │
#  ╰──────╯
source "$HOME/.config/zsh/chruby.zsh"
chruby 3

# ╭───────────────╮
# │ Python        │
# ╰───────────────╯
source "$HOME/.rye/env"
export PATH="$HOME/.rye/lib:$PATH"

# ╭───────────────────────────╮
# │ Trying out homebrew's nvm │
# ╰───────────────────────────╯
# Try fnm instead of nvm
eval "$(fnm env --use-on-cd)"

# ╭────────────────────────────╮
# │ Make mason tools available │
# ╰────────────────────────────╯
export PATH=$PATH:~/.local/share/nvim/mason/bin

# ╭────────────────────╮
# │ opam configuration │
# ╰────────────────────╯
# [[ ! -r /Users/steve.loveless/.opam/opam-init/init.zsh ]] || source /Users/steve.loveless/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# ╭─────────────────────────────────╮
# │ Android Studio for React Native │
# ╰─────────────────────────────────╯
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
# According to `cargo-mobile`, ANDROID_HOME is deprecated, replaced by ANDROID_SDK_ROOT.
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_NDK_ROOT=$HOME/Library/Android/sdk/ndk
export NDK_HOME=$HOME/Library/Android/sdk/ndk

# Use LLVM's `lld` for bevy
export PATH=$PATH:/opt/homebrew/opt/llvm/bin
