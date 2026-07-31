{ ... }:
{
  flake.homeModules."grammar" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ harper ];
    };
}
