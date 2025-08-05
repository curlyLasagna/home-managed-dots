# Work related config for MacBook

{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    mongodb-compass

    # ops
    awscli2
    docker
    terraform
    terragrunt
    terraform-ls
    tflint

    # lang

    ## webdev
    typescript-language-server

    ## Python
    basedpyright
    ruff
  ];
}
