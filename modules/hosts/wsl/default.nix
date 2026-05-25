{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;

  pkgsLinux = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations.wsl = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgsLinux;
    modules = [
      hm.inputs
      # Inlined from base
      ({ config, lib, pkgs, ... }: {
        home = {
          username = "luis";
          homeDirectory = "/home/${config.home.username}";
          stateVersion = "23.11";
          sessionVariables = { EDITOR = "nvim"; };
        };
        programs.home-manager.enable = true;
        services.home-manager.autoExpire = {
          enable = true;
          frequency = "weekly";
          timestamp = "-7 days";
        };
      })
      # Modules
      hm.lf
      hm."peon-ping"
      hm.grammar
      hm.spell
      hm.lua
      hm.markdown
      hm.nix
      hm.yaml
      hm.fish
      hm.starship
      hm.zsh
      hm.alacritty
      hm.wezterm
      hm.zellij
      hm.core
      hm.direnv
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.search
      hm.zoxide
      # Editors
      hm.nixvim
      hm.helix
    ];
  };
}
