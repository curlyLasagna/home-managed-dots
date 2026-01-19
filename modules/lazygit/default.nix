{ config, lib, ... }:

with lib;
let cfg = config.modules.lazygit;
in {
  options.modules.lazygit = {
    enable = mkEnableOption "Lazygit TUI for Git";
  };

  config = mkIf cfg.enable {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          activeBorderColor = [
            "#cba6f7"
            "bold"
          ];
          inactiveBorderColor = [ "#6c6f85" ];
          optionsTextColor = [ "#1e66f5" ];
          selectedLineBgColor = [ "reverse" ];
          cherryPickedCommitBgColor = [ "#bcc0cc" ];
          cherryPickedCommitFgColor = [ "#dd7878" ];
          unstagedChangesColor = [ "#d20f39" ];
          defaultFgColor = [ "#4c4f69" ];
          searchingActiveBorderColor = [ "#df8e1d" ];
        };

        authorColors = {
          "*" = "#7287fd";
        };
      };
    };
  };
};
}
