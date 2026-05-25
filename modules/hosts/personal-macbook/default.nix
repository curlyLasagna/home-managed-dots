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
          username = lib.mkDefault "luis";
          homeDirectory = lib.mkDefault (if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${config.home.username}" else "/home/${config.home.username}");
          stateVersion = "23.11";
          sessionVariables = { EDITOR = "nvim"; };
          packages = with pkgs; [
            tree
            unixtools.watch
            wget
            opencode
          ];
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
      # hm."peon-ping"
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
      hm.direnv
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.search
      hm.zoxide
      # hm.aerospace
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
