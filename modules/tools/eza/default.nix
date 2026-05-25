{ ... }:
{
  flake.modules.homeManager."eza" = { ... }:
    {
      programs.eza = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        git = true;
        icons = "auto";
      };
    };
}
