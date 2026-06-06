{ ... }:
{
  flake.homeModules."eza" =
    { ... }:
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
