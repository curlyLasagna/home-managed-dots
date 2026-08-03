{ ... }:
{
  flake.homeModules.yazi = {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
      enableFishIntegration = true;
      enableZshIntegration = true;

      settings = {
        mgr = {
          ratio = [
            1
            3
            4
          ];
          sort_by = "natural";
          sort_sensitive = false;
          sort_reverse = false;
          sort_dir_first = true;
          linemode = "none";
          show_hidden = false;
          show_symlink = true;
        };

        preview = {
          tab_size = 2;
          max_width = 1000;
          max_height = 1000;
          cache_dir = "";
          image_filter = "triangle";
          image_quality = 75;
          sixel_fraction = 15;
          ueberzug_scale = 1;
          ueberzug_offset = [
            0
            0
            0
            0
          ];
        };

        opener = {
          edit = [
            {
              run = "$EDITOR \"$@\"";
              block = true;
              for = "unix";
            }
          ];
        };
      };
    };
  };
}
