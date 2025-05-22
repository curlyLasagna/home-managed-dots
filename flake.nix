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
  };

  outputs = inputs@{self, flake-utils, nixpkgs, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem(system:
    let
      pkgs = import nixpkgs {inherit system; };
    in {
      legacyPackages = {
        homeConfigurations."luis" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./home.nix ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
    });
}
