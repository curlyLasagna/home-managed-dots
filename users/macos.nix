{
  pkgs,
  ...
}:

{
  imports = [
    ./shared.nix
    ../modules/fish
    # Terminal emulators
    ../modules/ghostty
    ../modules/alacritty
    ../modules/git
    ../modules/starship
  ];

  home.packages = with pkgs; [
    # GUI apps
    vscode
    obsidian
    hoppscotch
    zed-editor
    emacs-pgtk
    vivaldi
    skimpdf
    iina
    utm

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
    EDITOR = "emacsclient -c -a emacs";
    ESHELL = "${pkgs.fish}";
  };
  # PATH
  home.sessionPath = [
    "/opt/homebrew/bin"
    "/Users/luis/.local/bin"
    "/Users/luis/.ghcup/bin"
    "/Users/luis/.config/emacs/bin"
  ];

  xdg.configFile = {

    "nvim" = {
      source = ../dots/nvim;
    };

    "doom" = {
      source = ../dots/doom;
    };

    "zellij/config.kdl" = {
      source = ../dots/zellij/config.kdl;
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

    plugins = [
      # Need this when using Fish as a default macOS shell in order to pick up ~/.nix-profile/bin
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

  programs.git = {
    extraConfig = {
      credential.helper = "osxkeychain";
      ssh = {
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
      };
    };
  };
}
