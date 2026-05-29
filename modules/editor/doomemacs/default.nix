{ ... }:
{
  flake.homeModules."doomemacs" = { pkgs, config, ... }: {
    xdg.configFile."doom".source = ./doom;
    home.packages = [ pkgs.emacs-lsp-booster];
    # Assuming this is where doom emacs is installed
    home.sessionPath = [
      "${config.home.homeDirectory}/.config/emacs/bin"
    ];
  };
}
