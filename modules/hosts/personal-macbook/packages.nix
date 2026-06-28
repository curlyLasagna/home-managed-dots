{ inputs, ... }:
{
  flake.homeModules."personal-packages" =
    { pkgs, ... }:
    {
      home.packages =
        with pkgs;
        [
          obsidian
          skimpdf
          iina
          utm
          tree
          unixtools.watch
          wget
          opencode
        ]
        ++ [ inputs.herdr.packages.${pkgs.system}.default ];
    };
}
