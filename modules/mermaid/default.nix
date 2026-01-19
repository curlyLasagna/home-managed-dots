{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.mermaid;
in {
  options.modules.mermaid = {
    enable = mkEnableOption "Mermaid CLI with Puppeteer support";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ mermaid-cli ungoogled-chromium ];
    home.sessionVariables = {
      PUPPETEER_EXECUTABLE_PATH = "${pkgs.ungoogled-chromium}/bin/chromium";
      PUPPETEER_ARGS = "--no-sandbox --disable-setuid-sandbox";
    };
  };
}