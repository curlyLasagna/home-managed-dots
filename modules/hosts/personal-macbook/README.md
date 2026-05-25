# personal-macbook

Personal M1 MacBook (Apple Silicon, `aarch64-darwin`).

Notes:

- Intended for personal use.
- Home Manager config sets `home.username = "luis"` and `home.homeDirectory = "/Users/luis"`.
- macOS hosts import nixpkgs with the `emacs-lsp-booster` overlay.

Run:

```sh
home-manager build --flake .#personal-macbook
home-manager switch --flake .#personal-macbook
```
