{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
  emacsOverlay = inputs.emacs-lsp-booster.overlays.default;

  pkgs = import inputs.nixpkgs {
    system = "aarch64-darwin";
    overlays = [ emacsOverlay ];
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations."secured-macbook" = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules =
      (with hm; [
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
      ])
      ++ [
        hm.macos
        hm.ghostty
        hm.work
        hm."zed-editor"
      ];
  };
}
