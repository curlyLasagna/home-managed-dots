{
  languages = {
    Python = {
      formatter.language_server.name = "ruff";
      language_servers = [
        "ty"
        "ruff"
      ];
    };

    Nix.language_servers = [ "nixd" ];
  };

  lsp = {
    biome = {
      settings.inline_config = {
        linter = {
          rules = {
            complexity = {
              noStaticOnlyClass = "off";
            };
          };
        };
      };
    };
  };
}
