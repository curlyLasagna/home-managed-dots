{ ... }:
{
  flake.modules.homeManager."session-path" = { config, ... }:
    {
      home.sessionPath = [
        "${config.home.homeDirectory}/.ghcup/bin"
      ];
    };
}
