{ ... }:
{
  flake.modules.homeManager."lua" = { pkgs, ... }:
    {
      home.packages = with pkgs; [ stylua lua ];
    };
}
