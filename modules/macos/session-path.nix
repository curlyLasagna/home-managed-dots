{ ... }:
{
  flake.modules.homeManager.macos = {
    imports = [
      ({ config, ... }: {
        home.sessionPath = [
          "/opt/homebrew/bin"
          "${config.home.homeDirectory}/.local/bin"
          "${config.home.homeDirectory}/.config/emacs/bin"
        ];
      })
    ];
  };
}
