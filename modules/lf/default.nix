{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let cfg = config.modules.lf;
in {
  options.modules.lf = {
    enable = mkEnableOption "lf file manager";
  };

  config = mkIf cfg.enable {
  programs = {
    lf = {
      enable = true;
    };
    fish = {
      functions = {
        lfcd = {
          wraps = "lf";
          description = "lf - Terminal file manager (changing directory on exit)";
          body = ''cd "$(command lf -print-last-dir $argv)'';
        };
      };
    };
  };
};
}
