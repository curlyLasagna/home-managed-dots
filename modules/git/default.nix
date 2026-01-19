{ config, lib, ... }:

with lib;
let cfg = config.modules.git;
in {
  options.modules.git = {
    enable = mkEnableOption "Git version control";
  };

  config = mkIf cfg.enable {
  programs.git = {
    enable = true;

    settings = {
      user = {
        email = "luis.gcodes@gmail.com";
        name = "luis";
      };
      alias.l = "log --graph --decorate --pretty=format:'%C(auto)%h %Cblue%ad %Cred%aN %C(auto)%d %n %s' --date=human";
      init.defaultBranch = "main";
      core.autocrlf = false;
      github.user = "curlyLasagna";
      branch.autoSetupMerge = "always";

      # For LFS, Home Manager doesn't support .lfs key natively, but
      # you can use extraConfig for it, although actual enablement is
      # done via programs.git.lfs.enable.
      "filter.lfs" = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = "true";
      };
    };
    ignores = [
      "# Compiled source #"
      "###################"
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      "# OS generated files #"
      "######################"
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"
      "# Packages #"
      "############"
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"
      "# Databases #"
      "######################"
      "*.sqlite"
      "*.retry"
    ];

     lfs.enable = true;
   };
};
}
