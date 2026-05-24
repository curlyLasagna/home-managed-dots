{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;

  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations.wsl = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = with hm; [
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
  };
}
