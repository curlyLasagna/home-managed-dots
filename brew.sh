#!/usr/bin/env sh

# Might as well
sudo xcode-select --install

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update
brew upgrade

# Install brew packages
brew bundle install


# Install nix :)
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
