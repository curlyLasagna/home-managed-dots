{
  config,
  pkgs,
  lib,
  alacritty-themes
  ...
}:
{
  home.packages = with pkgs; [
    # GUI apps
    vscode
    obsidian
    zed-editor
    hoppscotch

    # Fonts
    fira-code
    roboto-mono
    jetbrains-mono
    iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.zed-mono
  ];

  xdg.configFile = {
    "alacritty/theme.toml" = {
      source =
        let
          themeName = "tokyo_night";
          ext = "toml";
        in
        "${alacritty-themes}/themes/${themeName}.${ext}";
    };

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

        theme = light:Raycast_Light,dark:catppuccin-mocha

        # Cursor
        shell-integration-features = no-cursor
        cursor-style = block

        # Mac specific settings
        macos-icon = blueprint
        macos-titlebar-style = transparent
        macos-titlebar-proxy-icon = hidden
        macos-option-as-alt = true
        macos-window-shadow = true
      '';
    };
  };

  # GUI app configurations
  programs.aerospace = {
    enable = true;
    userSettings = {
      gaps = {
        inner.horizontal = 10;
        inner.vertical = 8;
        outer.left = 7;
        outer.bottom = 7;
        outer.top = 7;
        outer.right = 7;
      };
      mode = {
        main.binding = {
          ctrl-alt-h = "focus left --boundaries-action wrap-around-the-workspace";
          ctrl-alt-j = "focus down --boundaries-action wrap-around-the-workspace";
          ctrl-alt-k = "focus up --boundaries-action wrap-around-the-workspace";
          ctrl-alt-l = "focus right --boundaries-action wrap-around-the-workspace";

          ctrl-alt-n = "move-node-to-workspace next --wrap-around";
          ctrl-alt-p = "move-node-to-workspace prev --wrap-around";

          ctrl-alt-enter = "fullscreen --no-outer-gaps";

          cmd-ctrl-alt-h = "move left";
          cmd-ctrl-alt-j = "move down";
          cmd-ctrl-alt-k = "move up";
          cmd-ctrl-alt-l = "move right";

          alt-space = "layout floating tiling";
        };
        resize.binding = {
          minus = "resize smart -50";
          equal = "resize smart +50";
        };
      };
    };
  };

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
          family = "ZedMono Nerd Font";
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

  fonts.fontconfig.enable = true;
}
