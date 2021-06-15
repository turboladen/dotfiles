# https://github.com/rweng/pry-rails
export DISABLE_PRY_RAILS=1

# Ruby
# Link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded)...
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
