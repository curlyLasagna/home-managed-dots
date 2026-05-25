{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.ui = {
    imports = [
      # hm.aerospace
    ];
  };
}
