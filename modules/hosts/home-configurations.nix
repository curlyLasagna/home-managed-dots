{ inputs, lib, ... }:
{
  flake = {
    homeConfigurations =
      let
        hm = inputs.self.modules.homeManager;
        emacsOverlay = inputs.emacs-lsp-booster.overlays.default;

        # Only override Zed from a pinned nixpkgs revision so it can be
        # substituted from Hydra even if current nixos-unstable is broken.
        profiles = rec {
          common = with hm; [
            base
            zsh
            fzf
            helix
            zoxide
            eza
            fish
            git
            starship
            lazygit
            nixvim
            doomemacs
            lf
          ];

          darwin = common ++ [
            hm.macos
            hm.ghostty
          ];
        };

        hosts = {
          macbook = {
            system = "aarch64-darwin";
            overlays = [
              emacsOverlay
            ];
            aspects = profiles.darwin ++ [
              hm.personal
              hm.zed-editor
            ];
          };

          secured-macbook = {
            system = "aarch64-darwin";
            overlays = [
              emacsOverlay
            ];
            aspects = profiles.darwin ++ [
              hm.work
              hm.zed-editor
            ];
            username = "secured-luis"
          };

          wsl = {
            system = "x86_64-linux";
            aspects = profiles.common;
          };

          secured-linux = {
            system = "x86_64-linux";
            aspects = profiles.common ++ [
              hm.work
            ];
            username = "clark";
            homeDirectory = "/home/clark";
          };
        };
      in
      builtins.mapAttrs (
        _name:
        {
          system,
          aspects,
          overlays ? [ ],
          allowUnfree ? true,
          username ? null,
          homeDirectory ? null,
        }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system overlays;
            config.allowUnfree = allowUnfree;
          };
        in
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules =
            aspects
            # Optionally specify username and home directory
            ++ lib.optional (username != null || homeDirectory != null) {
              home =
                (lib.optionalAttrs (username != null) {
                  inherit username;
                })
                // (lib.optionalAttrs (homeDirectory != null) {
                  inherit homeDirectory;
                });
            };
        }
      ) hosts;
  };
}
