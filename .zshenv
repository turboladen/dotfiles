# ╭─────────────────────────────────────────────────────────────────────────╮
# │ This file is _always_ sourced; ~/.zshrc is only sourced for interactive │
# │ sessions. Keep dev tools here so nvim spawned processes can access them │
# ╰─────────────────────────────────────────────────────────────────────────╯

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

# ╭───────────────────────────╮
# │ Fast Node Manager         │
# ╰───────────────────────────╯
eval "$(fnm env --use-on-cd)"
# export PATH="$HOME/Library/Application Support/fnm:$PATH"

# ╭────────────────────────────╮
# │ Make mason tools available │
# ╰────────────────────────────╯
export PATH=$PATH:~/.local/share/nvim/mason/bin

# ╭────────────────────╮
# │ opam configuration │
# ╰────────────────────╯
# [[ ! -r /Users/steve.loveless/.opam/opam-init/init.zsh ]] || source /Users/steve.loveless/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# ╭───────────────────────────╮
# │ Use LLVM's `lld` for bevy │
# ╰───────────────────────────╯
export PATH=$PATH:/opt/homebrew/opt/llvm/bin
