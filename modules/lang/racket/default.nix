{ ... }:
{
  flake.homeModules."racket" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ racket ];
    };
}
