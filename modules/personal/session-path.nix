{ ... }:
{
  flake.modules.homeManager.personal = {
    imports = [
      ({ config, ... }: {
        home.sessionPath = [
          "${config.home.homeDirectory}/.ghcup/bin"
        ];
      })
    ];
  };
}
