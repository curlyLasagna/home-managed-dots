{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.base = {
    imports = [
      hm.home
      hm.programs
      hm.services
    ];
  };
}
