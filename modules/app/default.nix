{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.app = {
    imports = [
      hm.lf
      # hm."peon-ping"
    ];
  };
}
