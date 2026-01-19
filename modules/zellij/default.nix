{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let cfg = config.modules.zellij;
in {
  options.modules.zellij = {
    enable = mkEnableOption "Zellij terminal multiplexer";
  };

  config = mkIf cfg.enable {
  programs.zellij.enable = true;
  xdg.configFile = {
    "zellij" = {
      source = ./dots;
    };
  };
};
}
