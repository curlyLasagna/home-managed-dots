{ ... }:
{
  flake.modules.homeManager.macos =
    { ... }:
    {
      programs.git.settings = {
        credential.helper = "osxkeychain";
        ssh = {
          AddKeysToAgent = "yes";
          UseKeychain = "yes";
        };
      };
    };
}
