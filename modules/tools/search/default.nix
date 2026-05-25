{ ... }:
{
  flake.modules.homeManager."search" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ripgrep
        fd
        bat
        jq
      ];
    };
}
