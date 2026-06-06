{ ... }:
{
  flake.homeModules."helix" =
    { ... }:
    {
      programs.helix = {
        enable = true;
        settings = {
          theme = "base16_transparent";
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
    };
}
