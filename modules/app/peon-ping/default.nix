{ inputs, ... }:
{
  flake.homeModules."peon-ping" =
    { config, pkgs, ... }:
    let
      peonPackage = inputs.peon-ping.packages.${pkgs.system}.default;
    in
    {
      imports = [ inputs.peon-ping.homeManagerModules.default ];

      programs.peon-ping = {
        enableZshIntegration = false;
        enable = true;
        package = peonPackage;
        settings = {
          default_pack = "Rapper ad-libs";
          volume = 1.0;
          enabled = true;
          desktop_notifications = true;
          categories = {
            "session.start" = true;
            "task.complete" = true;
            "task.error" = true;
            "input.required" = true;
            "resource.limit" = true;
            "user.spam" = false;
          };
        };
        installPacks = [
          {
            name = "Rapper ad-libs";
            src = pkgs.fetchFromGitHub {
              owner = "garysheng";
              repo = "peonping-rapper-adlibs";
              rev = "main";
              sha256 = "sha256-MYQITWqHXZUcoQZbIYKu80k/okS9q677LuDivihDrfw=";
            };
          }
        ];
      };

      home.file.".codex/hooks.json".text = builtins.toJSON {
        description = "Peon ping hook";
        hooks = {
          SessionStart = [
            {
              matcher = "startup|resume";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          SessionEnd = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          SubagentStart = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          SubagentStop = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          UserPromptSubmit = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          Stop = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                  timeout = 10;
                }
              ];
            }
          ];
          Notification = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          PermissionRequest = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          PreToolUse = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          PostToolUseFailure = [
            {
              matcher = "Bash";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
          PreCompact = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
                }
              ];
            }
          ];
        };
      };
    };
}
