# Local Variables:
# compile-command: "home-manager switch --flake .#luis@"
# End:
{
  description = "Home Manager configuration for multiple devices under the user Luis";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix2vim = {
      url = "github:nix-community/nixvim";
    };
    emacs-lsp-booster.url = "github:slotThe/emacs-lsp-booster-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    # Pick Alacritty themes
    alacritty-themes = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };

    peon-ping.url = "github:PeonPing/peon-ping";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      alacritty-themes,
      nix2vim,
      emacs-lsp-booster,
      zen-browser,
      peon-ping,
      ...
    }:

    {
      # Macbook configuration
      # MacOS user configs assumes you have brew installed
      homeConfigurations = {
        "luis@macbook" = home-manager.lib.homeManagerConfiguration ({
          modules = [
            nix2vim.homeModules.nixvim
            ./users/personal_macos.nix
          ];
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            overlays = [ emacs-lsp-booster.overlays.default ];
          };
          extraSpecialArgs = {
            inherit alacritty-themes zen-browser;
          };
        });

        # Very barebones. I rarely use x86-64 machines nowadays
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
            nix2vim.homeModules.nixvim
            peon-ping.homeManagerModules.default
            ./users/macos.nix
            ./users/secured.nix
          ];

          extraSpecialArgs = {
            inherit alacritty-themes peon-ping;
          };

          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            overlays = [ emacs-lsp-booster.overlays.default ];
          };
        });
      };
    };
}
