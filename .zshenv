#------------------------------------------------------------------------------
# This file is _always_ sourced; ~/.zshrc is only sourced for interactive
# sessions
#------------------------------------------------------------------------------

source ~/.chruby.zsh

# Rust
export PATH=$PATH:/Users/sloveless/.cargo/bin
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
