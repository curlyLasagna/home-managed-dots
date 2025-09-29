{
  # config,
  pkgs,
  # alacritty-themes,
  zen-browser,
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
    zen-browser.homeModules.beta
  ];

  home.packages = with pkgs; [
    # GUI apps
    vscode
    obsidian
    hoppscotch
    zed-editor
    emacs-pgtk

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

  programs.zen-browser = {
    enable = true;
    policies =
      let
        mkExtensionSettings = builtins.mapAttrs (
          _: pluginID: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginID}/latest.xpi";
            installation_mode = "force_installed";
          }
        );
      in
      {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        TranslateEnabled = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings = mkExtensionSettings {
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
        };
      };
  };
}
