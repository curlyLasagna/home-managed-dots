# Local Variables:
# compile-command: "home-manager switch --flake .#luis@"
# End:
{
  description = "Home Manager configuration for multiple devices under the user Luis";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    # Pick Alacritty themes
    alacritty-themes = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };
  };

  outputs =
    inputs@{
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
            ./users/macos.nix
          ];
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
          };
          extraSpecialArgs = {
            alacritty-themes = alacritty-themes;
            zen-browser = inputs.zen-browser;
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
            ./users/macos.nix
            ./users/secured.nix
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
