{ inputs, ... }:
{
  flake.modules.homeManager.alacritty =
    let
      themes = inputs.alacritty-themes;
    in
    { config, pkgs, ... }:
    let
      # Previously this was controlled by an option. Keep a simple heuristic:
      # if zellij is enabled, run it.
      useZellij = config.programs.zellij.enable or false;
    in
    {
      programs.alacritty = {
        enable = true;
        settings = {
          terminal.shell = {
            program = "${pkgs.fish}/bin/fish";
            args =
              if useZellij then
                [
                  "--login"
                  "--interactive"
                  "-c"
                  "zellij"
                ]
              else
                [
                  "--login"
                  "--interactive"
                ];
          };
          window = {
            padding = {
              x = 10;
              y = 8;
            };
            startup_mode = "Windowed";
            dynamic_padding = true;
            dynamic_title = true;
            option_as_alt = "Both";
            decorations = "Buttonless";
            decorations_theme_variant = "Dark";
          };
          font = {
            normal = {
              family = "JetBrainsMono Nerd Font";
              style = "Regular";
            };
            size = 13;
          };
          selection.save_to_clipboard = true;
          general.import = [ "${config.xdg.configFile."alacritty/theme.toml".source}" ];
        };
      };

      xdg.configFile."alacritty/theme.toml".source =
        let
          themeName = "kanagawa_dragon";
          ext = "toml";
        in
        "${themes}/themes/${themeName}.${ext}";
    };
}
