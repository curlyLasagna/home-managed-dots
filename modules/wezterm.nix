{ ... }:
{
  flake.modules.homeManager.wezterm =
    { ... }:
    {
      programs.wezterm.enable = true;
      xdg.configFile."wezterm".source = ./wezterm/dots;
    };
}
