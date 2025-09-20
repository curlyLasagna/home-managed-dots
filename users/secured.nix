# Work related config for MacBook
{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    mongodb-compass
    slack

    # ops
    awscli2
    aws-sam-cli
    terraform
    terragrunt
    terraform-ls
    tflint
    colima

    # lang

    # lsp
    typescript-language-server

    # linter/formatter
    biome

    ## Python
    uv

    # lsp
    basedpyright

    # linter/formatter
    ruff
  ];

  programs.fish = {
    # Convert the https urls to git for all the different submodules
    shellAbbrs = {
      https_to_ssh = "perl -i -p -e 's|https://(.*?)/|git@\\1:|g' .gitmodules";
    };
  };
}
