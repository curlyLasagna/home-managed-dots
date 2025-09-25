{ pkgs, ... }:
# ghostty for darwin is currently bork
{
  xdg.configFile = {
    "ghostty/config" = {
      text = ''
        command = ${pkgs.fish}/bin/fish --login --interactive
        # Aesthetics
        font-family = JetBrains Mono
        font-size = 13
        window-theme = auto

        window-padding-x = 15
        window-padding-y = 15,0
        window-inherit-working-directory = true

        theme = light:Catppuccin Latte,dark:Catppuccin Mocha

        # Cursor
        shell-integration-features = no-cursor
        cursor-style = block

        # Mac specific settings
        macos-icon = blueprint
        macos-titlebar-style = transparent
        macos-titlebar-proxy-icon = hidden
        macos-non-native-fullscreen = true
        macos-option-as-alt = true
        macos-window-shadow = true
      '';
    };
  };
}
