{ ... }:
{
  flake.modules.homeManager.base = {
    imports = [
      ({ pkgs, ... }: {
        home.packages = with pkgs; [
          bat
          coreutils
          curl
          devenv
          fd
          gawkInteractive
          opencode
          hunspell
          hyperfine
          jq
          lazydocker
          lazygit
          marksman
          harper
          nil
          nixfmt-rfc-style
          pandoc
          pipx
          ripgrep
          stylua
          tokei
          tree
          unixtools.watch
          wget
          xh
          emacs-lsp-booster
          yaml-language-server
          zoxide
          zstd
        ];
      })
    ];
  };
}
