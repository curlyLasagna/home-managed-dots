# Work related config for MacBook

{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.fish = {
    shellAbbrs = {
      mongo-compass = "NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#mongodb-compass --impure";
    };
  };
}
