{
  config,
  pkgs,
  alacritty-themes,
  ...
}:

{
  nixpkgs.config = {
    # Allow useful packages 😜
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };
  # Store relative to `.config` directory
  xdg = {
    enable = true;
    configFile = {
      "nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink /Users/luis/.config/home-manager/dots/nvim;
      };
      # Download alacritty theme from alacritty-themes
      "alacritty/theme.toml" = {
        source =
          let
            themeName = "tokyo_night";
            ext = "toml";
          in
          "${alacritty-themes}/themes/${themeName}.${ext}";
      };

      "ghostty/config".text = ''
        command = ${pkgs.fish}/bin/fish --login --interactive
        # Aesthetics
        font-family = ZedMono Nerd Font
        font-size = 13
        window-theme = auto

        window-padding-x = 15
        window-padding-y = 15,0
        window-inherit-working-directory = false

        theme = light:Raycast_Light,dark:catppuccin-mocha

        # Cursor
        shell-integration-features = no-cursor
        cursor-style = block

        # Mac
        macos-icon = retro
        macos-titlebar-style = hidden
        macos-titlebar-proxy-icon = hidden
        macos-option-as-alt = true
      '';

      # Who uses kdl?
      "zellij/config.kdl".text = ''
        on_force_close "quit"
        show_startup_tips false
        default_shell "fish"
        theme "tokyo-night"
        keybinds {
          pane {
              bind "h" { MoveFocus "Left"; }
              bind "l" { MoveFocus "Right"; }
              bind "j" { MoveFocus "Down"; }
              bind "k" { MoveFocus "Up"; }
          }
          tab {
              bind "h" { GoToPreviousTab; }
              bind "l" { GoToNextTab; }
          }
          resize {
            bind "h" { Resize "Increase Left"; }
            bind "j" { Resize "Increase Down"; }
            bind "k" { Resize "Increase Up"; }
            bind "l" { Resize "Increase Right"; }
            bind "H" { Resize "Decrease Left"; }
            bind "J" { Resize "Decrease Down"; }
            bind "K" { Resize "Decrease Up"; }
            bind "L" { Resize "Decrease Right"; }
          }
        }
      '';
    };
  };

  fonts.fontconfig.enable = true;
  home = {
    username = "luis";
    homeDirectory = "/Users/luis";
    stateVersion = "23.11";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    packages = with pkgs; [
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # cli apps
      bat
      coreutils
      curl
      devenv
      fd
      gawkInteractive
      hyperfine
      jq
      python313
      lazydocker
      lazygit
      neovim
      nil
      nixfmt-rfc-style
      pandoc
      pipx
      ripgrep
      stylua
      tokei
      tree
      unixtools.watch
      wget
      xh
      yaml-language-server
      yazi
      zoxide

      # gui apps
      vscode
      obsidian
      zed-editor
      hoppscotch

      # fonts
      fira-code
      roboto-mono
      jetbrains-mono
      iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.zed-mono
    ];

    file = { };
    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/luis/etc/profile.d/hm-session-vars.sh
    sessionVariables = {
      ALTERNATE_EDITOR = "";
      VISUAL = "emacsclient -c -a emacs";
      EDITOR = "emacsclient -t";
    };
    # PATH
    sessionPath = [
      "/opt/homebrew/bin"
      "/Users/luis/.local/bin"
      "/Users/luis/.ghcup/bin"
      "/Users/luis/.config/emacs/bin"
    ];

  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "luis";
      userEmail = "luis.gcodes@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
      lfs = {
        enable = true;
      };
    };

    fish = {
      enable = true;
      # Add brew completions to fish
      interactiveShellInit = ''
        if test -d (brew --prefix)"/share/fish/completions"
          set -p fish_complete_path (brew --prefix)/share/fish/completions
        end

        if test -d (brew --prefix)"/share/fish/vendor_completions.d"
          set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
        end
      '';
      shellAbbrs = {
        ls = "eza";
        ee = "emacsclient -r --no-wait";
        enw = "emacsclient -nw ";
        cd = "z";
      };
      functions = {
        clean_local_branch = {
          body = ''
            git fetch -p
            git branch -vv | rg ': gone]' | rg -v "\*" | awk '{print $1}' | xargs git branch -d
          '';
        };
      };
      # Need this when using Fish as a default macOS shell in order to pick up ~/.nix-profile/bin
      plugins = [
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
          };
        }
      ];
    };

    direnv = {
      enable = true;
      silent = true;
    };

    zsh = {
      enable = true;
      autocd = true;
      syntaxHighlighting.enable = true;
      completionInit = "autoload -Uz compinit && compinit";
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "zsh-users/zsh-syntax-highlighting"; }
          { name = "zsh-users/zsh-history-substring-search"; }
        ];
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        command_timeout = 100000;
        add_newline = false;
        scan_timeout = 30;
        nix_shell = {
          symbol = "❄ ";
        };
        shell = {
          fish_indicator = "🐟";
          zsh_indicator = "Z";
          nu_indicator = "Nu";
          style = "dimmed";
          disabled = false;
        };
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };

    zellij = {
      enable = true;
    };

    # GUI apps

    aerospace = {
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
        mode.main.binding = {
          ctrl-alt-h = "focus left --boundaries-action wrap-around-the-workspace";
          ctrl-alt-j = "focus down --boundaries-action wrap-around-the-workspace";
          ctrl-alt-k = "focus up --boundaries-action wrap-around-the-workspace";
          ctrl-alt-l = "focus right --boundaries-action wrap-around-the-workspace";

          ctrl-alt-n = "move-node-to-workspace next --wrap-around";
          ctrl-alt-p = "move-node-to-workspace prev --wrap-around";

          ctrl-alt-f = "fullscreen --no-outer-gaps";

          cmd-ctrl-alt-h = "move left";
          cmd-ctrl-alt-j = "move down";
          cmd-ctrl-alt-k = "move up";
          cmd-ctrl-alt-l = "move right";
        };
      };
    };

    alacritty = {
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
  };
}
