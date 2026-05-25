{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.lang = {
    imports = [
      hm.emacs
      hm.lua
      hm.markdown
      hm.nix
      hm.yaml
    ];
  };
}
