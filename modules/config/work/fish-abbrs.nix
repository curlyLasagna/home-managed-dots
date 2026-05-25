{ ... }:
{
  flake.modules.homeManager."fish-abbrs" = { ... }:
    {
      programs.fish.shellAbbrs = {
        https_to_ssh = "perl -i -p -e 's|https://(.*?)/|git@\\1:|g' .gitmodules";
        del_tflock = "find . -type f -name '.terraform.lock.hcl' -exec rm {} +";
      };
    };
}
