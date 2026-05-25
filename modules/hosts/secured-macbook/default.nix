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
  flake.homeConfigurations."secured-macbook" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgsMac;
    modules = [
      hm.inputs
      # Inlined from base
      ({ config, lib, pkgs, ... }: {
        home = {
          username = lib.mkDefault "luis";
          homeDirectory = lib.mkDefault (if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${config.home.username}" else "/home/${config.home.username}");
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
      hm.emacs
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
      hm.aerospace
      hm.macos
      # Work specific
      hm."secured-macbook-fish-abbrs"
      hm."secured-macbook-packages"
      # Editors
      hm.ghostty
      hm.doomemacs
      hm."zed-editor"
    ];
  };
}
