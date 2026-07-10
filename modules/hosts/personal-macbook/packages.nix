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
        ]
        ++ [ inputs.herdr.packages.${pkgs.system}.default ];
    };
}
