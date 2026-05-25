{ ... }:
{
  flake.modules.homeManager.base = {
    imports = [
      ({ ... }: {
        programs.home-manager.enable = true;
      })
    ];
  };
}
