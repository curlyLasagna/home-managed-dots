{ ... }:
{
  flake.modules.homeManager."personal-session-path" = { config, ... }:
    {
      home.sessionPath = [
        "${config.home.homeDirectory}/.ghcup/bin"
      ];
    };
}
