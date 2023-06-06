# Fix openssl related shared library builds for rust
brew_prefix="$(brew --prefix)"

export OPENSSL_INCLUDE_DIR="$brew_prefix/opt/openssl/include"
export OPENSSL_ROOT_DIR="$brew_prefix/opt/openssl"
export OPENSSL_LIB_DIR="$brew_prefix/opt/openssl/lib"

# For rustup, completions
fpath+=~/.zfunc
