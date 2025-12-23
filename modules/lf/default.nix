{
  config,
  lib,
  pkgs,
  ...
}:

{
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
}
