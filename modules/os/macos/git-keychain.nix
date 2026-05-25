{ ... }:
{
  flake.modules.homeManager.macos = {
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
