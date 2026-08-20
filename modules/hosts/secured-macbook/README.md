# secured-macbook

Work-only M3 MacBook (Apple Silicon, `aarch64-darwin`).

Notes:

- Strictly for work.
- Home Manager config sets `home.username = "luis"` and `home.homeDirectory = "/Users/luis"`.

Run:

```sh
home-manager build --flake .#secured-macbook
home-manager switch --flake .#secured-macbook
```
