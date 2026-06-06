{ ... }:
{
  flake.homeModules."wezterm" =
    { config, ... }:
    {
      programs.wezterm.enable = true;

      # Template wezterm.lua with the correct shell
      xdg.configFile."wezterm/wezterm.lua".text =
        builtins.replaceStrings [ "fish" ] [ config.myHost.defaultShell ]
          (builtins.readFile ./wezterm.lua);
      xdg.configFile."wezterm/config/init.lua".source = ./config/init.lua;
    };
}
