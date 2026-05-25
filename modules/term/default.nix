{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.term = {
    imports = [
      # hm.alacritty
      # hm.wezterm
      # hm.zellij
      hm.ghostty
    ];
  };
}
