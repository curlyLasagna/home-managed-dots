{ ... }:
{
  flake.modules.homeManager.base =
    { ... }:
    {
      programs = {
        home-manager.enable = true;

        direnv = {
          enable = true;
          silent = true;
        };

        zsh = {
          enable = true;
          autocd = true;
          syntaxHighlighting.enable = true;
          completionInit = "autoload -Uz compinit && compinit";
          zplug = {
            enable = true;
            plugins = [
              { name = "zsh-users/zsh-autosuggestions"; }
              { name = "zsh-users/zsh-syntax-highlighting"; }
              { name = "zsh-users/zsh-history-substring-search"; }
            ];
          };
        };

        fzf = {
          enable = true;
          enableFishIntegration = true;
          enableZshIntegration = true;
        };

        helix = {
          enable = true;
          settings = {
            editor = {
              "line-number" = "relative";
              bufferline = "multiple";
              statusline = {
                left = [
                  "mode"
                  "file-name"
                  "position"
                  "position-percentage"
                ];
                right = [
                  "diagnostics"
                  "spinner"
                  "file-type"
                  "version-control"
                ];
                mode = {
                  normal = "N";
                  insert = "I";
                  select = "S";
                };
              };
              "soft-wrap".enable = true;
              "file-picker".hidden = false;
              whitespace.characters = {
                nbsp = "⍽";
                tab = "→";
                newline = "⏎";
              };
              "cursor-shape" = {
                insert = "bar";
                normal = "block";
              };
              gutters."line-numbers"."min-width" = 1;
            };
            keys = {
              normal."A-x" = "command_mode";
              insert."C-g" = "normal_mode";
              select."C-g" = "normal_mode";
            };
          };
        };

        zoxide = {
          enable = true;
          enableFishIntegration = true;
          enableZshIntegration = true;
        };

        eza = {
          enable = true;
          enableFishIntegration = true;
          enableZshIntegration = true;
          git = true;
          icons = "auto";
        };
      };
    };
}
