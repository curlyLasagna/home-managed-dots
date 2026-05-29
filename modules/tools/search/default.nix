{ ... }:
{
  flake.homeModules."search" =
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
