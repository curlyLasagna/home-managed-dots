{ pkgs, ... }:
# ghostty for darwin is currently bork in nixpkgs so it's installed via brew
let
  hasZellij = pkgs ? zellij;
  cmd =
    if hasZellij then
      "${pkgs.fish}/bin/fish --login --interactive -c  ${pkgs.zellij}/bin/zellij"
    else
      "${pkgs.fish}/bin/fish --login --interactive";
in
{
  xdg.configFile = {
    "ghostty/config" = {
      text = ''
        command = ${pkgs.fish}/bin/fish --login --interactive
        # Aesthetics
        font-family = JetBrains Mono
        font-size = 13
        window-theme = auto

        window-padding-x = 5
        window-padding-y = 2
        window-inherit-working-directory = true

        theme = Kanagawa Dragon

        # Cursor
        shell-integration-features = no-cursor
        cursor-style = block

        quick-terminal-position = center
        quick-terminal-screen = mouse
        window-new-tab-position = end

        # Mac specific settings
        macos-icon = official
        macos-titlebar-style = transparent
        macos-titlebar-proxy-icon = hidden
        macos-non-native-fullscreen = true
        macos-option-as-alt = true
        macos-window-shadow = true
      '';
    };
  };
}
