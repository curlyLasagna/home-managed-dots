{ ... }:
{
  flake.modules.homeManager.macos =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.roboto-mono
        nerd-fonts.zed-mono
        alegreya
        julia-mono
      ];
    };
}
