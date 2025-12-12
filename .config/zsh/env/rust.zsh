# ╭──────────────────────────────────────────────╮
# │ Rust - OpenSSL for shared library builds    │
# ╰──────────────────────────────────────────────╯
export OPENSSL_INCLUDE_DIR="$HOMEBREW_PREFIX/opt/openssl/include"
export OPENSSL_ROOT_DIR="$HOMEBREW_PREFIX/opt/openssl"
export OPENSSL_LIB_DIR="$HOMEBREW_PREFIX/opt/openssl/lib"

# For rustup completions
fpath+=~/.zfunc
