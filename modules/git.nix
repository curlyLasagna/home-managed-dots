{ ... }:
{
  flake.modules.homeManager.git =
    { ... }:
    {
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
