{ inputs, ... }:
{
  flake.homeModules."personal-packages" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Personal
        obsidian
        skimpdf
        iina
        utm
        gh-dash
        posting
        # Work
        mongodb-compass
        slack
        codex
        awscli2
        uv
        openspec
        hoppscotch
      ];
    };
}
