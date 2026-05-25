{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
  emacsOverlay = inputs.emacs-lsp-booster.overlays.default;

  pkgsMac = import inputs.nixpkgs {
    system = "aarch64-darwin";
    overlays = [ emacsOverlay ];
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations."personal-macbook" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgsMac;
    modules = [
      hm.inputs
      # Inlined from base
      ({ config, lib, pkgs, ... }: {
        home = {
          username = "luis";
          homeDirectory = "/Users/${config.home.username}";
          stateVersion = "23.11";
          sessionVariables = { EDITOR = "nvim"; };
        };
        programs.home-manager.enable = true;
        services.home-manager.autoExpire = {
          enable = true;
          frequency = "weekly";
          timestamp = "-7 days";
        };
        home.sessionPath = [
          "${config.home.homeDirectory}/.ghcup/bin"
        ];
      })
      # Modules
      hm.lf
      hm.spell
      hm.lua
      hm.markdown
      hm.nix
      hm.yaml
      hm.fish
      hm.starship
      hm.zsh
      hm.direnv
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.search
      hm.zoxide
      hm.macos
      # Personal specific
      hm."personal-latexmkrc"
      hm."personal-packages"
      hm."personal-session-path"
      hm.ghostty
      # Editors
      hm.doomemacs
      hm."zed-editor"
    ];
  };
}
