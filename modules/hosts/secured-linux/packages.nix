{ ... }:
{
  flake.homeModules."secured-linux-packages" = { pkgs, ... }:
    {
      home.packages = with pkgs; [
        terraform
        terragrunt
        terraform-ls
        tflint
        docker
      ];
    };
}
