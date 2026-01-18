{ pkgs, ... }:
let
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
in
{
  xdg.configFile = {
    "doom" = {
      source = ./doom;
    };
  };
  home.packages = with pkgs; [
    tex
  ];
}
