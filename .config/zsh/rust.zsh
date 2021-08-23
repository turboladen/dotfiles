# Fix openssl related shared library builds for rust
export OPENSSL_INCLUDE_DIR="$(brew --prefix)/opt/openssl/include"
export OPENSSL_ROOT_DIR="$(brew --prefix)/opt/openssl"
export OPENSSL_LIB_DIR="$(brew --prefix)/opt/openssl/lib"

# For rustup, completions
fpath+=~/.zfunc
