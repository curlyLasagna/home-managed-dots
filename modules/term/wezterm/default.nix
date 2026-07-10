{ ... }:
{
  flake.homeModules."wezterm" =
    { config, ... }:
    {
      programs.wezterm.enable = true;

      # Set to custom defaultShell. fish is fallback
      xdg.configFile."wezterm/wezterm.lua".text =
        builtins.replaceStrings
          # from `fish`
          [ "fish" ]
          # to whatever shell you say is your default shell
          [ config.myHost.defaultShell ]
          # wezterm file
          (builtins.readFile ./wezterm.lua);
      xdg.configFile."wezterm/config/init.lua".source = ./config/init.lua;
    };
}
