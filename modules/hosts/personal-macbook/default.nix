{ inputs, ... }:
let
  hm = inputs.self.homeModules;
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
      hm."global-options"
      # Global options value
      (
        { ... }:
        {
          myHost = {
            defaultShell = "fish";
            multiplexer = "herdr";
            git = {
              name = "Luis";
              email = "luis.gcodes@gmail.com";
              githubUserName = "curlyLasagna";
            };
          };
        }
      )
      # Home-manager
      (
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          home = {
            username = "luis";
            homeDirectory = "/Users/${config.home.username}";
            stateVersion = "23.11";
            sessionVariables = {
              EDITOR = "emacs -nw";
            };
          };
          programs.home-manager.enable = true;
          services.home-manager.autoExpire = {
            enable = true;
            frequency = "weekly";
            timestamp = "-7 days";
          };
        }
      )
      # Modules
      hm.spell
      hm.lua
      hm.markdown
      hm.nix
      hm.core
      hm.yaml
      hm.fish
      hm.starship
      hm.zsh
      hm.direnv
      hm.herdr
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.zoxide
      hm.macos
      # Personal specific
      hm."latex"
      hm."personal-packages"
      hm.ghostty
      # Editors
      hm.nixvim
      hm.doomemacs
      hm."zed-editor"
    ];
  };
}
