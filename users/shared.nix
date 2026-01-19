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

    allowUnfree = true; # Allow useful packages 😜
  };

  imports = [
    ../modules/fish
    ../modules/git
    ../modules/starship
    ../modules/lazygit
    ../modules/nix2vim
    ../modules/doomemacs
    ../modules/lf
    ../modules/mermaid
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
      mermaid-cli
      opencode
      hunspell # spell checker
      hyperfine
      jq
      lazydocker
      lazygit
      marksman # markdown lsp
      harper # grammar lsp
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
    home-manager.enable = true; # Let Home Manager install and manage itself.

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
        timestamp = "-7 days";
      };
    };
  };

  modules = {
    fish.enable = true;
    git.enable = true;
    starship.enable = true;
    lazygit.enable = true;
    nix2vim.enable = true;
    doomemacs = {
      enable = true;
      texSupport = true;
    };
    lf.enable = true;
    mermaid.enable = true;
  };
}
