{ ... }:
{
  flake.modules.homeManager.doomemacs =
    { pkgs, ... }:
    let
      tex = pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-full
          dvisvgm
          dvipng
          wrapfig
          amsmath
          ulem
          hyperref
          capt-of
          ;
      };
    in
    {
      xdg.configFile."doom".source = ./doom;

      # Mirrors previous `texSupport = true` default.
      home.packages = [ tex ];
    };
}
