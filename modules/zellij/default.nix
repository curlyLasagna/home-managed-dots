{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.configFile = {
    "zellij" = {
      source = ./dots;
    };
  };
}
