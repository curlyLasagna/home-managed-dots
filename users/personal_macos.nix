{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./shared.nix
    ./macos.nix
  ];

  home.packages = with pkgs; [
    # GUI apps
    vscode
    obsidian
    skimpdf
    iina
    utm
  ];

  modules = {
    ghostty.enable = true;
  };
}
