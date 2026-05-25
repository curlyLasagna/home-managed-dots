{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.work = {
    imports = [
      hm."fish-abbrs"
      hm.packages
    ];
  };
}
