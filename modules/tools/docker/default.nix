{ ... }:
{
  flake.homeModules."docker" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # docker
        orbstack
        lazydocker
      ];
    };
}
