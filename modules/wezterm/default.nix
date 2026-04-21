{ ... }:
{
  flake.modules.homeManager.wezterm =
    { ... }:
    {
      programs.wezterm.enable = true;

      # Link only the actual wezterm config files.
      xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
      xdg.configFile."wezterm/config/init.lua".source = ./config/init.lua;
    };
}
