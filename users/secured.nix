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
    pyright

    # linter/formatter
    ruff
  ];

  programs.fish = {
    shellAbbrs = {
      # Convert the https urls to git for each submodules
      https_to_ssh = "perl -i -p -e 's|https://(.*?)/|git@\\1:|g' .gitmodules";
      # Recursively deletes terraform lock files
      del_tflock = "find . -type f -name '.terraform.lock.hcl' -exec rm {} +";
    };
  };
}
