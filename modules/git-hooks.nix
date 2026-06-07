{ inputs, ... }:
{
  perSystem = { system, pkgs, config, ... }: {
    checks.pre-commit-check = inputs.git-hooks.lib.${system}.run {
      src = ../.;
      hooks = {
        nixfmt-rfc-style.enable = true;

        flake-check = {
          enable = true;
          name = "Nix Flake Check";
          entry = "nix flake check";
          files = "\\.nix$";
          pass_filenames = false;
        };

        test-hosts = {
          enable = true;
          name = "Dry Run Hosts Configurations";
          entry = builtins.toString (pkgs.writeShellScript "test-hosts" ''
            set -e
            echo "Evaluating host configurations..."
            hosts=$(${pkgs.nix}/bin/nix eval --json '.#homeConfigurations' --apply 'builtins.attrNames' | ${pkgs.jq}/bin/jq -r '.[]')
            for host in $hosts; do
              echo "Dry building $host..."
              ${pkgs.nix}/bin/nix build ".#homeConfigurations.\"$host\".activationPackage" --dry-run
            done
          '');
          files = "\\.nix$";
          pass_filenames = false;
        };
      };
    };

    formatter = 
      let
        preCommitConfig = config.checks.pre-commit-check.config;
      in pkgs.writeShellScriptBin "pre-commit-run" ''
        ${pkgs.lib.getExe preCommitConfig.package} run --all-files --config ${preCommitConfig.configFile}
      '';

    devShells.default = pkgs.mkShell {
      shellHook = ''
        ${config.checks.pre-commit-check.shellHook}
      '';
      buildInputs = config.checks.pre-commit-check.enabledPackages;
    };
  };
}
