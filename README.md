# ❄️ Home-manager managed dotfiles ❄️

Home-manager config for MacOS and WSL. 
Home is where your dots is :)

## Setup

### Install nix via Determinate Nix Installer

`curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`

### Clone repo

`git clone https://github.com/curlyLasagna/home-managed-dots`

### Enable flakes

Add the following line in your `nix.conf` file

`experimental-features = nix-command flakes`

### Activate config 

WSL: `nix run home-manager/master -- switch --flake .#luis@wsl `

macos: `nix run home-manager/master -- switch --flake .#luis@macbook`

## Workflow

- Emacs for editing config files or systems programming. Also magit is ❤️
- Nvim when I forget how to use Emacs
- Starship as my shell prompt
- Fish as default shell
- Alacritty + zellij or Ghostty, depends how much I want to show off

## Cross Platform

### WSL

`nix run home-manager/master -- switch --flake #.luis@wsl`

All CLI applications. Not going to bother with any GUI apps. I'll let Windows deal with that.

### MacOS

`nix run home-manager/master -- switch --flake #.luis@macbook`

> Will switch over to nix-darwin when time allows.
> Home-Manager is good enough to start working
