{ inputs, ... }:
let
  hm = inputs.self.modules.homeManager;
in
{
  flake.modules.homeManager.tools = {
    imports = [
      hm.core
      hm.direnv
      hm.docker
      hm.eza
      hm.fzf
      hm.git
      hm.lazygit
      hm.search
      hm.zoxide
      hm.agent-harness
    ];
  };
}
