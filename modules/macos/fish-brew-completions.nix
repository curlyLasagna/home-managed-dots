{ ... }:
{
  flake.modules.homeManager.macos =
    { pkgs, ... }:
    {
      programs.fish = {
        interactiveShellInit = ''
          if test -d (brew --prefix)"/share/fish/completions"
            set -p fish_complete_path (brew --prefix)/share/fish/completions
          end

          if test -d (brew --prefix)"/share/fish/vendor_completions.d"
            set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
          end
        '';

        plugins = [
          {
            name = "nix-env";
            src = pkgs.fetchFromGitHub {
              owner = "lilyball";
              repo = "nix-env.fish";
              rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
              sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
            };
          }
        ];

        shellAbbrs = {
          brew_deps = "brew deps --tree --installed";
        };
      };
    };
}
