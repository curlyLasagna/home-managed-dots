{ ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      command_timeout = 100000;
      add_newline = false;
      scan_timeout = 30;
      nix_shell = {
        symbol = "❄ ";
      };
      shell = {
        fish_indicator = "🐟";
        zsh_indicator = "Z";
        nu_indicator = "Nu";
        style = "dimmed";
        disabled = false;
      };
    };
  };
}
