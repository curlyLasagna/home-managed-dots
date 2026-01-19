{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.doomemacs;
  # Minimal set of tex packages for Emacs Orgmode
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        dvisvgm
        dvipng
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        ;
    }
  );
in {
  options.modules.doomemacs = {
    enable = mkEnableOption "Doom Emacs configuration";
    texSupport = mkEnableOption "TeX packages for Org mode";
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "doom" = {
        source = ./doom;
      };
    };
    home.packages = with pkgs; optional cfg.texSupport tex;
  };
}
