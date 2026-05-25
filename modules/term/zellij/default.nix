{ ... }:
{
  flake.modules.homeManager."zellij" = { ... }:
    {
      programs.zellij.enable = true;

      # Link only the actual zellij config files.
      xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    };
}
