{
  description = "Home Manager configuration of luis";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # Pick Alacritty themes
    alacritty-themes = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
      home-manager,
      alacritty-themes,
      ...
    }:

    {
      # Macbook configuration
      homeConfigurations = {
        "luis@macbook" = home-manager.lib.homeManagerConfiguration ({
          modules = [
            ./home.nix
            ./macos.nix
          ];
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
          };
          extraSpecialArgs = {
            alacritty-themes = alacritty-themes;
          };
        });

        "luis@wsl" = home-manager.lib.homeManagerConfiguration ({
          modules = [
            ./home.nix
          ];
          pkgs = import nixpkgs {
            system = "x86_64-linux";
          };
        });

        "luis@secured_macbook" = home-manager.lib.homeManagerConfiguration ({
          modules = [
            ./home.nix
            ./macos.nix
            ./work.nix
          ];

          extraSpecialArgs = {
            alacritty-themes = alacritty-themes;
          };

          pkgs = import nixpkgs {
            system = "aarch64-darwin";
          };
        });
      };
    };
}
