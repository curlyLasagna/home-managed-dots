# Home Manager Configuration Diagram

```mermaid
graph TD
    A[Flake Inputs: nixpkgs, home-manager, nix2vim, emacs-lsp-booster, alacritty-themes] --> B[Outputs: homeConfigurations]

    B --> C[luis@macbook: macos.nix + nix2vim]
    B --> D[luis@wsl: linux.nix]
    B --> E[luis@secured_macbook: macos.nix + secured.nix]

    C --> F[macos.nix imports: shared.nix + ghostty module]
    D --> G[linux.nix imports: shared.nix]
    E --> H[secured.nix imports: shared.nix + additional security]

    F --> I[shared.nix imports modules: fish, git, starship, lazygit, nix2vim, doomemacs, lf]
    G --> I
    H --> I

    I --> J[Common packages: bat, fd, ripgrep, etc.]
    I --> K[Programs: direnv, zsh, fzf, zoxide, eza]

    C --> L[Mac-specific: packages like vscode, fonts + fish/git settings]
    E --> M[Secured: additional security configs]
```
