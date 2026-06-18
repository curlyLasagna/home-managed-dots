{ ... }:
{
  flake.homeModules."minimal-emacs" =
    { pkgs, config, ... }:
    {
      xdg.configFile."emacs".source = ./config;
      home.packages = [ pkgs.emacs-lsp-booster ];
    };
}
