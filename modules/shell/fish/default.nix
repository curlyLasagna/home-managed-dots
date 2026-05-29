{ ... }:
{
  flake.homeModules."fish" =
    { ... }:
    {
      programs.fish = {
        enable = true;
        shellAbbrs = {
          ls = "eza";
          ee = "emacsclient -c --no-wait";
          enw = "emacsclient -nw ";
          cd = "z";
        };
        functions = {
          clean_local_branch.body = ''
            git fetch -p
            git branch -vv | rg ': gone]' | rg -v "\\*" | awk '{print $1}' | xargs git branch -d
          '';
        };
      };
    };
}
