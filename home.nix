{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # Store config files within `.config` directory
  xdg = {
    enable = true;
    configFile = {
      "nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink /Users/luis/.config/home-manager/dots/nvim;
      };
      "doom" = {
        source = config.lib.file.mkOutOfStoreSymlink ./dots/doom;
      };
      "aerospace" = {
        source = config.lib.file.mkOutOfStoreSymlink ./dots/aerospace;
      };
      # Terminal emulator
      "ghostty/config".text = ''
        command = ${pkgs.fish}/bin/fish --login --interactive
        # Aesthetics
        font-family = JetBrains Nerd Font Mono
        font-size = 13
        window-theme = auto

        window-padding-x = 10
        window-padding-y = 10,0
        window-inherit-working-directory = true

        theme = light:tokyonight-day,dark:catppuccin-mocha

        # Cursor
        shell-integration-features = no-cursor
        cursor-style = block

        # Mac
        macos-icon = holographic
        macos-titlebar-style = transparent
        macos-titlebar-proxy-icon = hidden
        macos-option-as-alt = true
      '';

      # kdl is too niche for me to add a mode for
      "zellij/config.kdl".text = ''
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
  home = {
    username = "luis";
    homeDirectory = "/Users/luis";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11";
    packages = with pkgs; [
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
      bat
      curl
      devenv
      fd
      lazydocker
      gawkInteractive
      hyperfine
      jq
      lazygit
      neovim
      nil
      nixfmt-rfc-style
      pandoc
      pipx
      ripgrep
      stylua
      tmux
      tokei
      tree
      unixtools.watch
      wget
      xh
      yaml-language-server
      yazi
      zoxide
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
    sessionVariables = { };
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
        ee = "emacsclient -c --no-wait";
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
      };
    };
  };
}
