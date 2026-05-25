{ ... }:
{
  flake.modules.homeManager."grammar" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ harper ];
    };
}
