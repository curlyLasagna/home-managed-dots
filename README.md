# ❄️ Home-manager managed dotfiles ❄️

My humble home-manager config for MacOS and WSL

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
