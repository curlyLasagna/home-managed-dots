{ inputs }:

{
  flake.homeModules.herdr =
    { pkgs, ... }:
    {
      home.packages = inputs.herdr.packages.${pkgs.system}.default;
      xdg.configFile.herdr.source = "config.toml";
    };
}
