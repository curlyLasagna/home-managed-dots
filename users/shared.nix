# Shared configuration for Linux and Mac
{
  pkgs,
  ...
}:

let
  isMac = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{

  nixpkgs.config = {
    # Allow useful packages 😜
    allowUnfree = true;
    allowUnfreePredicate = true;
  };

  home = {
    username = "luis";
    homeDirectory =
      if isMac then
        "/Users/luis"
      else if isLinux then
        "/home/luis"
      else
        "/home/luis";
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
      zstd
    ];

    file = { };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

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
        frequency = "weekly";
      };
    };
  };
}
