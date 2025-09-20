{ ... }:
{
  programs.git = {
    enable = true;
    userName = "luis";
    userEmail = "luis.gcodes@gmail.com";
    aliases = {
      l = "log --graph --decorate --pretty=format:'%C(auto)%h %Cblue%ad %Cred%aN %C(auto)%d %n    %s' --date=human";
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
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        autocrlf = false;
      };
      github.user = "curlyLasagna";
      branch.autoSetupMerge = "always";
    };
    lfs = {
      enable = true;
    };
  };
}
