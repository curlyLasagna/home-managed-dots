{ inputs, ... }:
{
  flake.modules.homeManager."peon-ping" = { pkgs, ... }:
    {
      imports = [ inputs.peon-ping.homeManagerModules.default ];

      programs.peon-ping = {
        enable = true;
      };
    };
}
