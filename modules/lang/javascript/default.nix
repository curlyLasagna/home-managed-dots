{ ... }:
{
  flake.homeModules."javascript" =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.nodejs_24 ];
    };
}
