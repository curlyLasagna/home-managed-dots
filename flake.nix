{
  description = "Home Manager configuration (Dendritic)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nix2vim.url = "github:nix-community/nixvim";
    emacs-lsp-booster.url = "github:slotThe/emacs-lsp-booster-flake";

    alacritty-themes = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };

    peon-ping.url = "github:PeonPing/peon-ping";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.modules
        (inputs.import-tree ./modules)
      ];
    };
}
