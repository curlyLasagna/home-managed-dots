{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.mermaid;
in {
  options.modules.mermaid = {
    enable = mkEnableOption "Mermaid CLI with Puppeteer support";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ mermaid-cli ];
    home.sessionVariables = {
      PUPPETEER_EXECUTABLE_PATH = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
      PUPPETEER_ARGS = "--no-sandbox --disable-setuid-sandbox";
    };
  };
}