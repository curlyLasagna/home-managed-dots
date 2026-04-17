{ inputs, ... }:
{
  flake = {
    homeConfigurations =
      let
        mkHome =
          {
            name,
            system,
            extraModules ? [ ],
            overlays ? [ ],
            allowUnfree ? true,
          }:
          let
            pkgs = import inputs.nixpkgs {
              inherit system overlays;
              config.allowUnfree = allowUnfree;
            };
          in
          {
            ${name} = inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = extraModules;
            };
          };
      in
      { }
      // (mkHome {
        name = "macbook";
        system = "aarch64-darwin";
        overlays = [ inputs.emacs-lsp-booster.overlays.default ];
        extraModules = with inputs.self.modules.homeManager; [
          base
          macos
          personal
          fish
          git
          starship
          lazygit
          nixvim
          doomemacs
          lf
          ghostty
        ];
      })
      // (mkHome {
        name = "secured-macbook";
        system = "aarch64-darwin";
        overlays = [ inputs.emacs-lsp-booster.overlays.default ];
        extraModules = with inputs.self.modules.homeManager; [
          base
          macos
          work
          fish
          git
          starship
          lazygit
          nixvim
          doomemacs
          lf
          ghostty
        ];
      })
      // (mkHome {
        name = "wsl";
        system = "x86_64-linux";
        extraModules = with inputs.self.modules.homeManager; [
          base
          fish
          git
          starship
          lazygit
          nixvim
          doomemacs
          lf
        ];
      });
  };
}
