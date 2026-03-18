# Work related config for MacBook
{
  pkgs,
  peon-ping,
  ...
}:

{

  home.packages = with pkgs; [
    mongodb-compass
    slack
    # Work has OpenAI subscription, tsk tsk Scam Altman but might as well use it 🫣
    codex
    vscode

    # ops
    awscli2
    terraform
    terragrunt
    terraform-ls
    tflint
    docker

    # lsp
    typescript-language-server

    # linter/formatter
    biome

    # lsp
    pyright

    # linter/formatter
    ruff
  ];

  programs.peon-ping = {
    enable = true;
    package = peon-ping.packages.${pkgs.system}.default;
  };

  modules = {
    ghostty.enable = true;
  };

  programs.fish = {
    shellAbbrs = {
      # Convert the https urls to git for each submodules
      https_to_ssh = "perl -i -p -e 's|https://(.*?)/|git@\\1:|g' .gitmodules";
      # Recursively deletes terraform lock files
      del_tflock = "find . -type f -name '.terraform.lock.hcl' -exec rm {} +";
    };
  };
}
