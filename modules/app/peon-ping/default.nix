{ inputs, ... }:
{
  flake.homeModules."peon-ping" =
    { pkgs, ... }:
    {
      imports = [ inputs.peon-ping.homeManagerModules.default ];

      programs.peon-ping = {
        enable = true;
        package = inputs.peon-ping.packages.${pkgs.system}.default;
        settings = {
          default_pack = "glados";
          volume = 0.7;
          enabled = true;
          desktop_notifications = true;
          categories = {
            "session.start" = true;
            "task.complete" = true;
            "task.error" = true;
            "input.required" = true;
            "resource.limit" = true;
            "user.spam" = true;
          };
        };
        installPacks = [
          {
            name = "Rapper ad-libs";
            src = pkgs.fetchFromGitHub {
              owner = "garysheng";
              repo = "peonping-rapper-adlibs";
              rev = "main"; # or a commit hash/tag
              sha256 = "sha256-MYQITWqHXZUcoQZbIYKu80k/okS9q677LuDivihDrfw="; # Leave empty first, Nix will tell you the correct hash
            };
          }
        ];
      };
    };
}
