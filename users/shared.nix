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
  };

  imports = [
    ../modules/fish
    ../modules/git
    ../modules/starship
    ../modules/lazygit
    ../modules/nix2vim
    ../modules/doomemacs
  ];

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

    packages = with pkgs; [
      bat
      coreutils
      curl
      devenv
      fd
      gawkInteractive
      hunspell
      hyperfine
      jq
      lazydocker
      lazygit
      marksman
      nil
      nixfmt-rfc-style
      pandoc
      pyenv
      pipx
      ripgrep
      stylua
      tokei
      tree
      unixtools.watch
      wget
      xh
      emacs-lsp-booster
      yaml-language-server
      zoxide
      zstd
    ];

    file = { };
    sessionVariables = {
      EDITOR = "nvim";
    };
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
