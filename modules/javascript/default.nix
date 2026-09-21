{ ... }:
{
  flake.homeModules."javascript" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.nodejs_24
        pkgs.typescript
        pkgs.vtsls
        pkgs.pnpm
      ];
    };
}
