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
    # Pick themes
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

    let
      args = {
        inherit (nixpkgs) lib;
        inherit alacritty-themes;
      };
    in
    {
      # Macbook configuration
      homeConfigurations = {
        "luis@macbook" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./shared.nix
            ./macos.nix
          ];

          extraSpecialArgs = args // {
            isMac = true;
            isLinux = false;
          };
        };
        "luis@wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./shared.nix
          ];

          extraSpecialArgs = args // {
            isMac = false;
            isLinux = true;
          };
        };
      };
    };
}
