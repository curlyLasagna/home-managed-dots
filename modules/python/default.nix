{
  config,
  lib,
  pkgs,
  ...
}:

{
  flake.homeModules."javascript" = { pkgs, ... }: {
    home.packages = [
      pkgs.ty
      pkgs.ruff
    ];
    programs.ty = {

    };
  };

}
