{ ... }:
{
  flake.modules.homeManager.base =
    { lib, pkgs, ... }:
    {
      home = {
        username = "luis";
        homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/luis" else "/home/luis";
        stateVersion = "23.11";

        sessionVariables = {
          EDITOR = "nvim";
        };
      };
    };
}
