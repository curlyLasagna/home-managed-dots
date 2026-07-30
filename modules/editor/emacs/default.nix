{ ... }:
{
  flake.homeModules."emacs" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.myHost.emacs;
    in
    {
      options.myHost.emacs = {
        profile = lib.mkOption {
          type = lib.types.enum [
            "doom"
            "minimal"
          ];
          default = "doom";
          description = "Emacs configuration flavor (doom or minimal)";
        };
      };

      config = lib.mkMerge [
        {
          programs.emacs = {
            enable = true;
          };

          # TODO: Fix emacsclient not rendering the correct colorscheme
          services.emacs = {
            enable = true;
          };

          programs.fish.shellAbbrs = {
            e = "emacs -nw .";
          };

          home.packages = [ pkgs.emacs-lsp-booster ];
        }
        (lib.mkIf (cfg.profile == "doom") {
          xdg.configFile."doom".source = ./doom/config;
          home.sessionPath = [
            "${config.home.homeDirectory}/.config/emacs/bin"
          ];
        })
        (lib.mkIf (cfg.profile == "minimal") {
          xdg.configFile."emacs".source = ./minimal/config;
        })
      ];
    };
}
