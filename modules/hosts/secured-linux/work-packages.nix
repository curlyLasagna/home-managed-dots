{ ... }:
{
  flake.modules.homeManager."secured-linux-packages" = { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mongodb-compass
        slack
        codex
        vscode

        awscli2
        terraform
        terragrunt
        terraform-ls
        tflint
        docker

        typescript-language-server
        biome
        pyright
        ruff
      ];
      programs.zed-editor = {
        extensions = [
          "angular"
        ];
      };
    };
}
