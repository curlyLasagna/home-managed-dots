{ ... }:
{
  flake.modules.homeManager."emacs" = { pkgs, ... }:
    {
      home.packages = with pkgs; [ emacs-lsp-booster ];
    };
}
