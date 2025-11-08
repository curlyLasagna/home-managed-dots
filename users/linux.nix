{
  pkgs,
  ...
}:
{
  imports = [
    ./shared.nix
    ../modules/fish
    ../modules/git
    ../modules/starship
  ];
}
