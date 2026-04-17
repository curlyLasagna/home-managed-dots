{ ... }:
{
  flake.modules.homeManager.zellij =
    { ... }:
    {
      programs.zellij.enable = true;
      xdg.configFile."zellij".source = ./zellij/dots;
    };
}
