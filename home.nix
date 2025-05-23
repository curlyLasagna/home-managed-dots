{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "luis";
  home.homeDirectory = "/Users/luis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    bat
    curl
    devenv
    fd
    awscli
    nil
    gawkInteractive
    jq
    nixfmt-rfc-style
    neovim
    lazygit
    nil
    tree
    pipx
    ranger
    ripgrep
    stylua
    tmux
    unixtools.watch
    wget
    yazi
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/nvim" = {
        # I have no idea why I have to spell the whole thing out
      source = config.lib.file.mkOutOfStoreSymlink /Users/luis/.config/home-manager/dots/nvim;
    };
    ".config/doom" = {
      source = config.lib.file.mkOutOfStoreSymlink ./dots/doom;
      # source = dots/doom;
    };
  };

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
  #
  home.sessionVariables = { };

  home.sessionPath = [
    "/opt/homebrew/bin"
    "/Users/luis/.local/bin"
    "/Users/luis/.ghcup/bin"
    "/Users/luis/.config/emacs/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Store config files within `.config` directory
  xdg.enable = true;

  programs.git = {
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

  programs.fish = {
    enable = true;
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
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z;
      }
    ];
  };

  programs.zsh = {
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
    profileExtra = ''
      export SHELL="$HOME/.nix-profile/bin/fish"
      exec "$SHELL"
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      command_timeout = 10000;
      add_newline = false;
      scan_timeout = 30;
      nix_shell = {
        symbol = "❄ ";
      };
      shell = {
        fish_indicator = "Fish";
        zsh_indicator = "Zsh";
        nu_indicator = "Nu";
        style = "dimmed";
        disabled = false;
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };
}
