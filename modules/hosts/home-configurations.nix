{ inputs, ... }:
{
  flake = {
    homeConfigurations =
      let
        hm = inputs.self.modules.homeManager;
        emacsOverlay = inputs.emacs-lsp-booster.overlays.default;

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
            overlays = [ emacsOverlay ];
            aspects = profiles.darwin ++ [ hm.personal ];
          };

          secured-macbook = {
            system = "aarch64-darwin";
            overlays = [ emacsOverlay ];
            aspects = profiles.darwin ++ [ hm.work ];
          };

          wsl = {
            system = "x86_64-linux";
            aspects = profiles.common;
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
        }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system overlays;
            config.allowUnfree = allowUnfree;
          };
        in
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = aspects;
        }
      ) hosts;
  };
}
