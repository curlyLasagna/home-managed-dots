#!/usr/bin/env sh

# Might as well
sudo xcode-select --install

# Install brew if you can't
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add homebrew to PATH to be able to run the commands below
eval $(/opt/homebrew/bin/brew shellenv)

# If brew is already installed, remove whatever is already installed
brew remove --force $(brew list --formula)
brew update
brew upgrade

# Install brew packages
brew bundle install

# Install nix :)
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
