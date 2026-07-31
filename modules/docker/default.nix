{ ... }:
{
  flake.homeModules."docker" =
    { pkgs, ... }:
    {
      home.packages =
        with pkgs;
        [ lazydocker ] ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [ orbstack ];
    };
}
