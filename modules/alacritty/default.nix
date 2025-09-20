{
  config,
  pkgs,
  alacritty-themes,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [
          "-l"
          "-i"
          "-c"
          "zellij"
        ];
      };
      window = {
        padding = {
          x = 10;
          y = 8;
        };
        startup_mode = "Windowed";
        dynamic_padding = true;
        dynamic_title = true;
        option_as_alt = "Both";
        decorations = "Buttonless";
        decorations_theme_variant = "Dark";
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 13;
      };
      selection.save_to_clipboard = true;
      general.import = [
        "${config.xdg.configFile."alacritty/theme.toml".source}"
      ];
    };
  };

  xdg.configFile = {
    "alacritty/theme.toml" = {
      source =
        let
          themeName = "ashes_dark";
          ext = "toml";
        in
        "${alacritty-themes}/themes/${themeName}.${ext}";
    };
  };
}
