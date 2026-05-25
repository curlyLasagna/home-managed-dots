{ ... }:
{
  flake.modules.homeManager.personal = {
    imports = [
      ({ pkgs, ... }: {
        home.packages = with pkgs; [
          obsidian
          skimpdf
          iina
          utm
        ];
      })
    ];
  };
}
