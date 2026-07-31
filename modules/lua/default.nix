{ ... }:
{
  flake.homeModules."lua" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        stylua
        lua
      ];
    };
}
