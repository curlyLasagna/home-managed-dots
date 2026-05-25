# ❄️ Home-manager managed dotfiles ❄️

Home-manager config for macOS (Apple Silicon), Linux, and WSL.
> Home is where your dots is :)

## Setup

### Install nix via Determinate Nix Installer

`curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`

### Clone repo

`git clone https://github.com/curlyLasagna/home-managed-dots`

### Enable flakes

Add the following line in your `nix.conf` file

`experimental-features = nix-command flakes`

## Hosts

This flake exposes these Home Manager configurations:

- `personal-macbook`: M1 MacBook for personal use
- `secured-macbook`: M3 MacBook strictly for work
- `secured-linux`: powerful Linux desktop
- `wsl`: WSL on an x86 Windows laptop

## Apply Configuration

If `home-manager` is already installed:

```sh
home-manager switch --flake .#personal-macbook
```

If you do not have `home-manager` installed yet (bootstrap via `nix run`):

```sh
nix run home-manager/master -- switch --flake .#personal-macbook
```

Replace `personal-macbook` with the host you want.

### WSL

Use `.#wsl` for CLI-focused configuration (Windows handles GUI apps).

```sh
nix run home-manager/master -- switch --flake .#wsl
```

### macOS

```sh
nix run home-manager/master -- switch --flake .#personal-macbook
```

#### Add ssh key to keychain

Interact with remote repos without having to enter your passphrase:

`ssh-add --apple-use-keychain <private key path>`

### SecurEd (Work) MacBook

```sh
nix run home-manager/master -- switch --flake .#secured-macbook
```

## Philosphy

I've enjoyed my time setting up a declarative config that I can understand.

I feel in control of my machine and that gives me a peace of mind.

I also wasn't a fan of having to learn different syntax per config (lua is cool and all but it's not my cup of tea 🫣)

- `modules`: Per application configuration
- `modules/hosts`: Per machine configuration

## Update packages

`nix flake update` to update the flake inputs
