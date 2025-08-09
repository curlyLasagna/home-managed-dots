{
  config,
  pkgs,
  lib,
  ...
}:

let
  isMac = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  unsupported = builtins.abort "Unsupported platform";
in
{
  nixpkgs.config = {
    # Allow useful packages 😜
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home = {
    username = "luis";
    homeDirectory =
      if isMac then
        "/Users/luis"
      else if isLinux then
        "/home/luis"
      else
        unsupported;
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
      bat
      coreutils
      curl
      devenv
      fd
      gawkInteractive
      hyperfine
      jq
      lazydocker
      lazygit
      marksman
      neovim
      nil
      nixfmt-rfc-style
      pandoc
      pipx
      python313
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
    ];

    file = { };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "luis";
      userEmail = "luis.gcodes@gmail.com";
      aliases = {
        l = "log --graph --decorate --pretty=format:'%C(auto)%h %Cblue%ad %Cred%aN %C(auto)%d %n    %s' --date=human";
      };
      ignores = [
        "# Compiled source #"
        "###################"
        "*.com"
        "*.class"
        "*.dll"
        "*.exe"
        "*.o"
        "*.so"
        "# OS generated files #"
        "######################"
        ".DS_Store"
        ".DS_Store?"
        "._*"
        ".Spotlight-V100"
        ".Trashes"
        "ehthumbs.db"
        "Thumbs.db"
        "# Packages #"
        "############"
        "*.7z"
        "*.dmg"
        "*.gz"
        "*.iso"
        "*.jar"
        "*.rar"
        "*.tar"
        "*.zip"
        "# Logs and databases #"
        "######################"
        "*.log"
        "*.sqlite"
        "*.retry"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        core = {
          autocrlf = false;
        };
        github.user = "curlyLasagna";
        branch.autoSetupMerge = "always";
      };
      lfs = {
        enable = true;
      };
    };

    fish = {
      enable = true;
      # Add brew completions to fish
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
  };

  services = {
    home-manager = {
      autoExpire = {
        enable = true;
        timestamp = "-7 days";
      };
    };
  };
}
