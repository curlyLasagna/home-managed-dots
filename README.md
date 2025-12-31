# ❄️ Home-manager managed dotfiles ❄️

Home-manager config for MacOS and WSL.
> Home is where your dots is :)

## Setup

### Install nix via Determinate Nix Installer

`curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`

### Clone repo

`git clone https://github.com/curlyLasagna/home-managed-dots`

### Enable flakes

Add the following line in your `nix.conf` file

`experimental-features = nix-command flakes`

### WSL

`nix run home-manager/master -- switch --flake .#luis@wsl`

All CLI applications. Not going to bother with any GUI apps. I'll let Windows deal with that.

### MacOS

`nix run home-manager/master -- switch --flake .#luis@macbook`

#### Add ssh key to keychain

Interact with remote repos without having to enter your passphrase:

`ssh-add --apple-use-keychain <private key path>`

### SecurEd (Work) MacBook

`nix run home-manager/master -- switch --flake .#luis@secured_macbook`

## Philosphy

I've enjoyed my time setting up a declarative config that I can understand.

I feel in control of my machine and that gives me a peace of mind.

I also wasn't a fan of having to learn different syntax per config (lua is cool and all but it's not my cup of tea 🫣)

- `modules`: Per application configuration
- `users`: Per device configuration

## Update packages

`nix flake update` to update the flake inputs
