{ ... }:
{
  flake.modules.homeManager."spell" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ hunspell ];
    };
}
