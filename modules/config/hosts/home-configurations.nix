{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
  emacsOverlay = inputs.emacs-lsp-booster.overlays.default;

  pkgsMac = import inputs.nixpkgs {
    system = "aarch64-darwin";
    overlays = [ emacsOverlay ];
    config.allowUnfree = true;
  };

  pkgsLinux = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  baseModules = [
    hm.inputs
  ]
  ++ (with hm; [
    app
    base
    checkers
    editor
    lang
    shell
    term
    tools
    ui
  ]);
in
{
  flake.homeConfigurations = {
    "personal-macbook" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsMac;
      modules = baseModules ++ [
        hm.os
        hm.personal
        hm.ghostty
        hm."zed-editor"
      ];
    };

    "secured-macbook" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsMac;
      modules = baseModules ++ [
        hm.os
        hm.work
        hm.ghostty
        hm."zed-editor"
      ];
    };

    "secured-linux" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsLinux;
      modules = baseModules ++ [
        hm.work
        {
          home = {
            username = "clark";
            homeDirectory = "/home/clark";
          };
        }
      ];
    };

    wsl = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsLinux;
      modules = baseModules;
    };
  };
}
