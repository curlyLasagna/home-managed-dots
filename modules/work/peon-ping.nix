{ inputs, ... }:
{
  flake.modules.homeManager.work =
    let
      peonPing = inputs.peon-ping;
    in
    { pkgs, ... }:
    {
      imports = [ peonPing.homeManagerModules.default ];

      programs.peon-ping = {
        enable = true;
        package = peonPing.packages.${pkgs.system}.default;
      };
    };
}
