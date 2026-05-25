{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.checkers = {
    imports = [
      # hm.grammar
      hm.spell
    ];
  };
}
