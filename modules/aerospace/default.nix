{ ... }:
{
  flake.homeModules."aerospace" =
    { ... }:
    {
      programs.aerospace = {
        launchd.enable = false;
        settings = {
          accordion-padding = 0;
          default-root-container-layout = "accordion";
          default-root-container-orientation = "horizontal";

          gaps = {
            inner.horizontal = 0;
            inner.vertical = 0;
            outer.left = 0;
            outer.bottom = 0;
            outer.top = 0;
            outer.right = 0;
          };

          mode.main.binding = {
            cmd-alt-rightSquareBracket = "focus right --boundaries-action wrap-around-the-workspace";
            cmd-alt-leftSquareBracket = "focus left --boundaries-action wrap-around-the-workspace";

            alt-cmd-h = "move left";
            alt-cmd-j = "move down";
            alt-cmd-k = "move up";
            alt-cmd-l = "move right";

            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-7 = "workspace 7";

            alt-shift-1 = "move-node-to-workspace 1 --focus-follows-window";
            alt-shift-2 = "move-node-to-workspace 2 --focus-follows-window";
            alt-shift-3 = "move-node-to-workspace 3 --focus-follows-window";
            alt-shift-4 = "move-node-to-workspace 4 --focus-follows-window";
            alt-shift-5 = "move-node-to-workspace 5 --focus-follows-window";
            alt-shift-6 = "move-node-to-workspace 6 --focus-follows-window";
            alt-shift-7 = "move-node-to-workspace 7 --focus-follows-window";

            alt-tab = "workspace next --wrap-around";
            alt-shift-tab = "workspace prev --wrap-around";
            alt-cmd-space = "layout floating tiling";

            alt-cmd-comma = "move-workspace-to-monitor --wrap-around prev";
            alt-cmd-period = "move-workspace-to-monitor --wrap-around next";
            alt-leftSquareBracket = "focus-monitor --wrap-around prev";
            alt-rightSquareBracket = "focus-monitor --wrap-around next";
            alt-shift-leftSquareBracket = "move-node-to-monitor --wrap-around --focus-follows-window prev";
            alt-shift-rightSquareBracket = "move-node-to-monitor --wrap-around --focus-follows-window next";

            alt-shift-semicolon = "mode service";
          };

          mode.service.binding = {
            enter = "mode main";
            r = [
              "reload-config"
              "mode main"
            ];

            minus = "resize smart -50";
            equal = "resize smart +50";

            v = [
              "layout v_tiles"
              "mode main"
            ];
            h = [
              "layout h_tiles"
              "mode main"
            ];
          };
        };
      };
    };
}
