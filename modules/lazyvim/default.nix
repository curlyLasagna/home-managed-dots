{ inputs, ... }:
let
  lua = ./lua;
in
{
  flake.homeModules.lazyvim =
    { ... }:
    {
      imports = [
        inputs.lazyvim.homeManagerModules.default
      ];
      programs.lazyvim = {
        enable = true;
        configFiles = lua;
      };
    };
}
