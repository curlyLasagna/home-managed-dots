{ ... }:
{
  flake.homeModules.macos = {
    imports = [
      ({ ... }: {
        programs.git.settings = {
          credential.helper = "osxkeychain";
          ssh = {
            AddKeysToAgent = "yes";
            UseKeychain = "yes";
          };
        };
      })
    ];
  };
}
