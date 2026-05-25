# wsl

WSL on an x86 Windows laptop (`x86_64-linux`).

Notes:

- Intended for CLI tooling; Windows manages GUI apps.
- Home Manager config sets `home.username = "luis"` and `home.homeDirectory = "/home/luis"`.

Run:

```sh
home-manager build --flake .#wsl
home-manager switch --flake .#wsl
```
