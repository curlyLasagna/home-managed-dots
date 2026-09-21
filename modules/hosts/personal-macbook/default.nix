{ inputs, ... }:
let
  hm = inputs.self.homeModules;

  pkgsMac = import inputs.nixpkgs {
    system = "aarch64-darwin";
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations."personal-macbook" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgsMac;
    extraSpecialArgs = { inherit inputs; };
    modules = [
      hm."global-options"
      # Global options value
      (
        { ... }:
        {
          myHost = {
            defaultShell = "fish";
            multiplexer = "herdr";
            git = {
              name = "Luis";
              email = "luis.gcodes@gmail.com";
              githubUserName = "curlyLasagna";
            };
          };
        }
      )
      # Home-manager
      (
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          home = {
            username = "luis";
            homeDirectory = "/Users/${config.home.username}";
            stateVersion = "23.11";
          };
          programs.home-manager.enable = true;
          services.home-manager.autoExpire = {
            enable = true;
            frequency = "weekly";
            timestamp = "-7 days";
          };
          # Doom Emacs profile alias
          # A little nasty but 🤷
          programs.fish.shellAbbrs = {
            es = "emacs -nw --profile securEd";
            ep = "emacs -nw --profile personal";
          };
        }
      )
      # Modules
      hm.spell
      hm.lua
      hm.markdown
      hm.nix
      hm.core
      hm.yaml
      hm.fish
      hm.starship
      hm.zsh
      hm.direnv
      hm.yazi
      hm.herdr
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.zoxide
      hm.macos
      hm.hunk
      hm.javascript
      # Personal specific
      hm.tex
      hm."personal-packages"
      # Scripts (work scripts like spin-up-staging)
      hm.scripts
      hm.ghostty
      # Alacritty theme repo returning 504 for some reason
      # hm.alacritty
      # Editors
      hm.lazyvim
      hm."zed-editor"
    ];
  };
}
