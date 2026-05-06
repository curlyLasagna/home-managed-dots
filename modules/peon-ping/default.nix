{ inputs, ... }:
{
  flake.modules.homeManager."peon-ping" =
    let
      peonPing = inputs.peon-ping;
    in
    { pkgs, ... }:
    {
      imports = [ peonPing.homeManagerModules.default ];

      programs.peon-ping = {
        enable = true;
      };
    };
}
