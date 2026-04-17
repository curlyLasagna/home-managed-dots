{ ... }:
{
  flake.modules.homeManager.base = {
    nixpkgs.config.allowUnfree = true;
  };
}
