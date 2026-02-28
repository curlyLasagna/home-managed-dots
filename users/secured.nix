# Work related config for MacBook
{
  pkgs,
  ...
}:

{

  home.packages = with pkgs; [
    mongodb-compass
    slack
    codex

    # ops
    awscli2
    terraform
    terragrunt
    terraform-ls
    tflint
    colima

    # lsp
    typescript-language-server

    # linter/formatter
    biome

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
