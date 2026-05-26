{
  ...
}:

{
  flake.modules.homeManager."haskell" =
    { pkgs, config, ... }:

    {
      home.packages = with pkgs; [ ghc ];
      home.sessionPath = [
        "${config.home.homeDirectory}/.ghcup/bin"
      ];
    };
}
