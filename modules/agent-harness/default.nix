{ ... }:
{
  flake.homeModules."agent-harness" =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.opencode ];
    };
}
