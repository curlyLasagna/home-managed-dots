{ ... }:
{
  flake.modules.homeManager.personal =
    { config, ... }:
    {
      home.sessionPath = [
        "${config.home.homeDirectory}/.ghcup/bin"
      ];
    };
}
