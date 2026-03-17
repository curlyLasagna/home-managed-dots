{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.lf;
in
{
  options.modules.lf = {
    enable = mkEnableOption "lf file manager";
  };

  config = mkIf cfg.enable {
    programs = {
      lf = {
        enable = true;
      };
    };
  };
}
