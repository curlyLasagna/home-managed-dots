{ ... }:
{
  flake.homeModules.scripts =
    { pkgs, ... }:
    let
      spinUpStaging = pkgs.writeShellApplication {
        name = "spin-up-staging";
        runtimeInputs = [ pkgs.awscli2 ];
        text = builtins.readFile ./spin-up-staging.sh;
      };

      spinUpStagingCompat = pkgs.writeShellApplication {
        name = "spin_up_staging";
        runtimeInputs = [ spinUpStaging ];
        text = ''
          exec spin-up-staging "$@"
        '';
      };
    in
    {
      home.packages = [
        spinUpStaging
        spinUpStagingCompat
      ];
    };
}
