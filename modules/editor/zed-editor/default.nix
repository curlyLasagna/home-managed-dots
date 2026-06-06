{ ... }:
{
  flake.homeModules."zed-editor" =
    { ... }:
    {
      programs.zed-editor = {
        enable = true;
        mutableUserSettings = true;
        mutableUserKeymaps = true;
        userSettings = {
          # Misc. settings
          cli_default_open_behavior = "new_window";
        };
      };
    };
}
