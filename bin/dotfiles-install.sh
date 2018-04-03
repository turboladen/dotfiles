#!/bin/sh

# Install homebrew
echo "Installing homebrew..."

if [ ! -d /usr/local/Cellar ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed."
fi

# Install homebrew things
echo "Installing Brewfile things..."
cd ~ || exit
brew bundle || echo "Couldn't brew bundle" && exit

# Install Ruby
echo "Installing Ruby..."
ruby-install ruby -- --enable-shared || echo "Couldn't ruby-install ruby" && exit
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby ruby
gem install bundler
bundle
echo "Done with Ruby."

# Install Rust
echo "Installing Rust..."
curl https://sh.rustup.rs -sSf | sh
rustup component add rls-preview rust-analysis rust-src
cargo install ripgrep
echo "Done with Rust."

mkdir ~/Development
mkdir ~/Development/projects
mkdir ~/Development/not_my_projects
