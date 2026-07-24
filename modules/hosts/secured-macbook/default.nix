{ inputs, ... }:
let
  hm = inputs.self.homeModules;
  emacsOverlay = inputs.emacs-lsp-booster.overlays.default;

  pkgsMac = import inputs.nixpkgs {
    system = "aarch64-darwin";
    overlays = [ emacsOverlay ];
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations."secured-macbook" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgsMac;
    modules = [
      hm.inputs
      hm."global-options"
      (
        { ... }:
        {
          myHost = {
            defaultShell = "fish";
            multiplexer = "herdr";
            git = {
              email = "luis.gcodes@gmail.com";
              name = "Luis";
              githubUserName = "curlyLasagna";
            };
          };
        }
      )
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
            sessionVariables = {
              EDITOR = "emacs -nw";
            };
          };

          programs.fish.shellAbbrs = {
            # Converts development-environment submodules remote url from https to ssh
            https_to_ssh = "perl -i -p -e 's|https://(.*?)/|git@\\1:|g' .gitmodules";
            # Deletes lock files
            del_tflock = "find . -type f -name '.terraform.lock.hcl' -exec rm {} +";

          };
          programs.fish.functions = {
            clear_iac_cache = ''
              find live -type d -name .terragrunt-cache -prune -exec rm -rf {} +
              find live -type d -name .terraform -prune -exec rm -rf {} +
            '';
          };
          programs.zed-editor = {
            extensions = [
              "angular"
            ];
          };

          programs.home-manager.enable = true;
          services.home-manager.autoExpire = {
            enable = true;
            frequency = "weekly";
            timestamp = "-7 days";
          };
        }
      )
      # Modules
      hm.spell
      hm.alacritty
      hm.markdown
      hm.nix
      hm.yaml
      hm.javascript
      hm.fish
      hm.nixvim
      hm."peon-ping"
      hm.starship
      hm.zsh
      hm.core
      hm.direnv
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.zoxide
      hm.macos
      hm.ghostty
      hm.herdr
      # Work packages
      hm."secured-macbook-packages"
      # Editors
      hm.doomemacs
      hm."zed-editor"
    ];
  };
}
