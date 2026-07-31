{ ... }:
{
  flake.homeModules."zellij" =
    { config, ... }:
    {
      programs.zellij.enable = true;

      # Template config.kdl with the correct shell
      xdg.configFile."zellij/config.kdl".text =
        builtins.replaceStrings
          [ "default_shell \"fish\"" ]
          [ "default_shell \"${config.myHost.defaultShell}\"" ]
          (builtins.readFile ./config.kdl);
    };
}
