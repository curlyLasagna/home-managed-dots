{ ... }:
{
  flake.modules.homeManager."agent-harness" =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.opencode ];
    };
}
