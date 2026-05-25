{ ... }:
{
  flake.modules.homeManager."fzf" = { ... }:
    {
      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
}
