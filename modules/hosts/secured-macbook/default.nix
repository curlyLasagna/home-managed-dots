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
              EDITOR = "nvim";
            };
          };

          programs.fish.shellAbbrs = {
            https_to_ssh = "perl -i -p -e 's|https://(.*?)/|git@\\1:|g' .gitmodules";
            del_tflock = "find . -type f -name '.terraform.lock.hcl' -exec rm {} +";
          };

          programs.zed-editor = {
            extensions = [
              "angular"
            ];
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
      hm.lf
      hm.spell
      hm.markdown
      hm.nix
      hm.yaml
      hm.fish
      hm.starship
      hm.zsh
      hm.core
      hm.direnv
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.search
      hm.zoxide
      hm.macos
      hm.helix
      # Work specific
      hm."secured-macbook-packages"
      # Editors
      hm.ghostty
      hm.doomemacs
      hm."zed-editor"
    ];
  };
}
