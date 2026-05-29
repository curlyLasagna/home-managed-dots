{ ... }:
{
  flake.homeModules."docker" = { pkgs, ... }:
    {
      home.packages = with pkgs; [ lazydocker ];
    };
}
