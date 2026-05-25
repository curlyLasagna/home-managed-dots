{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.personal = {
    imports = [
      hm.latexmkrc
      hm.packages
      hm."session-path"
    ];
  };
}
