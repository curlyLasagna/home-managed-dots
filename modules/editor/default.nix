{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.editor = {
    imports = [
      hm.doomemacs
      # hm.helix
      hm.nixvim
      hm.zed-editor
    ];
  };
}
