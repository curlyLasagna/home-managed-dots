{ ... }:
{
  flake.modules.homeManager."personal-packages" = { pkgs, ... }:
    {
      home.packages = with pkgs; [
        obsidian
        skimpdf
        iina
        utm
        tree
        unixtools.watch
        wget
        opencode
      ];
    };
}
