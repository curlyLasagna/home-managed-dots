{ ... }:
{
  flake.homeModules."secured-macbook-packages" = { pkgs, ... }:
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

        uv

      ];
    };
}
