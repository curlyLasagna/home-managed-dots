{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.shell = {
    imports = [
      hm.fish
      hm.starship
      hm.zsh
    ];
  };
}
