{
  config,
  pkgs,
  lib,
  isMac,
  isLinux,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home = {
    username = "luis";
    # Dynamically set homeDirectory based on OS
    homeDirectory = if isMac then "/Users/luis" else "/home/luis";
    stateVersion = "23.11"; # Keep this consistent with your current setting

    # Combine all common packages into a single list
    packages = with pkgs; [
      # CLI apps
      bat
      coreutils
      curl
      devenv
      fd
      gawkInteractive
      hyperfine
      jq
      lazydocker
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
    # Common program configurations
    programs = {
      home-manager.enable = true;

      git = {
        enable = true;
        userName = "luis";
        userEmail = "luis.gcodes@gmail.com";
        aliases = {
          l = "log --graph --decorate --pretty=format:'%C(auto)%h %Cblue%ad %Cred%aN %C(auto)%d %n     %s' --date=human";
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
          # Conditional credential helper
          credential.helper = if isMac then "osxkeychain" else "store"; # Or "cache" for Linux
          github.user = "curlyLasagna";
          branch.autoSetupMerge = "always";
        };
        lfs.enable = true;
      };

      fish = {
        enable = true;
        interactiveShellInit = lib.mkIf isMac ''
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
    };
  };
}
