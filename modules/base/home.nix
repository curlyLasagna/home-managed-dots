{ ... }:
{
  flake.modules.homeManager.base = {
    imports = [
      ({ config, lib, pkgs, ... }: {
        home = {
          username = lib.mkDefault "luis";
          homeDirectory = lib.mkDefault (
            if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${config.home.username}" else "/home/${config.home.username}"
          );
          stateVersion = "23.11";

          sessionVariables = {
            EDITOR = "nvim";
          };
        };
      })
    ];
  };
}
