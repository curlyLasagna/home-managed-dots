{ lazygit-theme }:
{
  xdg.configFile = {
    "lazygit/config.yml" = {
      source =
        let
          theme = "mocha";
          accent = "flamingo";
        in
        "${lazygit-theme}/${theme}/${accent}";
    };
  };
}
