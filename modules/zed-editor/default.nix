{ ... }:
{
  flake.homeModules."zed-editor" =
    { pkgs, ... }:
    {
      programs.zed-editor = {
        enable = true;
        package = pkgs.emptyDirectory;
        mutableUserSettings = true;
        mutableUserKeymaps = true;
        userSettings = {
          # Misc. settings
          cli_default_open_behavior = "new_window";
        };
      };
    };
}
