{ inputs, ... }:
{
  flake.homeModules."peon-ping" =
    { config, pkgs, ... }:
    let
      peonPackage = inputs.peon-ping.packages.${pkgs.system}.default;
      peonCodexAdapterPath = "${peonPackage}/share/peon-ping/adapters/codex.sh";
      peonCodexHook = {
        type = "command";
        command = "bash ${peonCodexAdapterPath}";
        timeout = 10;
      };
      mkPeonCodexHook = hook: {
        matcher = "";
        hooks = [ hook ];
      };
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
              rev = "main"; # or a commit hash/tag
              sha256 = "sha256-MYQITWqHXZUcoQZbIYKu80k/okS9q677LuDivihDrfw="; # Leave empty first, Nix will tell you the correct hash
            };
          }
        ];
      };

      home.file.".codex/hooks.json".text = builtins.toJSON {
        description = "Peon ping hook";
        hooks = {
          SessionStart = [ (mkPeonCodexHook peonCodexHook) ];
          SessionEnd = [ (mkPeonCodexHook peonCodexHook) ];
          SubagentStart = [ (mkPeonCodexHook peonCodexHook) ];
          SubagentStop = [ (mkPeonCodexHook peonCodexHook) ];
          UserPromptSubmit = [ (mkPeonCodexHook peonCodexHook) ];
          Stop = [ (mkPeonCodexHook peonCodexHook) ];
          Notification = [ (mkPeonCodexHook peonCodexHook) ];
          PermissionRequest = [ (mkPeonCodexHook peonCodexHook) ];
          PreToolUse = [ (mkPeonCodexHook peonCodexHook) ];
          PostToolUseFailure = [
            {
              matcher = "Bash";
              hooks = [ peonCodexHook ];
            }
          ];
          PreCompact = [ (mkPeonCodexHook peonCodexHook) ];
        };
      };
    };
}
