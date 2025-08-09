{
  config,
  pkgs,
  alacritty-themes,
  ...
}:

{
  home.packages = with pkgs; [
    # GUI apps
    vscode
    obsidian
    hoppscotch
    aerospace
    zed-editor

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono
    nerd-fonts.iosevka-term
    nerd-fonts.zed-mono
    julia-mono
  ];

  home.sessionVariables = {
    ALTERNATE_EDITOR = "";
    VISUAL = "emacsclient -c -a emacs";
    EDITOR = "emacsclient -t";
    ESHELL = "/Users/luis/.nix-profile/bin/fish";
  };
  # PATH
  home.sessionPath = [
    "/opt/homebrew/bin"
    "/Users/luis/.local/bin"
    "/Users/luis/.ghcup/bin"
    "/Users/luis/.config/emacs/bin"
  ];

  xdg.configFile = {
    "aerospace/aerospace.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dots/aerospace/aerospace.toml;
    };
    "alacritty/theme.toml" = {
      source =
        let
          themeName = "ashes_dark";
          ext = "toml";
        in
        "${alacritty-themes}/themes/${themeName}.${ext}";
    };

    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dots/nvim;
    };

    "doom" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dots/doom;
    };

    "zellij/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dots/zellij/config.kdl;
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
        macos-non-native-fullscreen = true
        macos-option-as-alt = true
        macos-window-shadow = true
      '';
    };
  };

  programs.fish = {
    interactiveShellInit = ''
      if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
      end

      if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
      end
    '';
  };

  programs.git = {
    extraConfig = {
      credential.helper = "osxkeychain";
      ssh = {
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
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

  fonts.fontconfig.enable = true;
}
