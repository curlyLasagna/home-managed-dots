{ ... }:
{
  flake.modules.homeManager."packages" = { pkgs, ... }:
    {
      home.packages = with pkgs; [
        obsidian
        skimpdf
        iina
        utm
      ];
    };
}
