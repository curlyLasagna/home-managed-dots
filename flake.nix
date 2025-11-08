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
    # Pick Alacritty themes
    alacritty-themes = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };
    catppuccin-lazygit = {
      url = "github:catppuccin/lazygit";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      alacritty-themes,
      catppuccin-lazygit,
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
            lazygit-theme = catppuccin-lazygit;
          };
        });

        "luis@wsl" = home-manager.lib.homeManagerConfiguration ({
          modules = [
            ./users/linux.nix
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
