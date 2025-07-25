{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    gcc
    nerd-fonts.zed-mono
  ];

  home.sessionPath = [
    "/Users/luis/.config/emacs/bin"
  ];

  home.sessionVariables = {
    ALTERNATE_EDITOR = "";
    VISUAL = "emacsclient -c -a emacs";
    EDITOR = "emacsclient -t";
    ESHELL = "/Users/luis/.nix-profile/bin/fish";
  };
}
