{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.os = {
    imports = [
      hm.macos
    ];
  };
}
