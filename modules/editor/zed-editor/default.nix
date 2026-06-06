{ ... }:
{
  flake.homeModules."zed-editor" =
    { config, pkgs, ... }:
    let
      settings = import ./settings.nix;
      languageSettings = import ./languages.nix;
      lspSettings = import ./lsp.nix;

      userSettings = {
        # Misc. settings
        cli_default_open_behavior = "new_window";
      }
      // settings.editorUiSettings
      // settings.formattingSettings
      // settings.vimSettings
      // settings.panelSettings
      // settings.terminalSettings
      // languageSettings
      // lspSettings
      // settings.predictionSettings
      // settings.agentSettings
      // settings.telemetrySettings
      // settings.fileScanSettings;

      userKeymaps = import ./keymaps.nix;
      userExtensions = import ./extensions.nix;

    in
    {
      programs.zed-editor = {
        enable = true;
        userSettings = userSettings;
        userKeymaps = userKeymaps;
        extensions = userExtensions;
        mutableUserSettings = true;
        mutableUserKeymaps = true;
      };
    };
}
