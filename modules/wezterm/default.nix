{ config, lib, ... }:

with lib;
let cfg = config.modules.wezterm;
in {
  options.modules.wezterm = {
    enable = mkEnableOption "WezTerm terminal emulator";
  };

  config = mkIf cfg.enable {
  programs.wezterm.enable = true;
  xdg.configFile = {
    "wezterm" = {
      source = ./dots;
    };
  };
};
}
