{ ... }:
{
  flake.modules.homeManager.personal =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        obsidian
        skimpdf
        iina
        utm
      ];
    };
}
