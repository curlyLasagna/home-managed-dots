# personal-macbook

MacBook (Apple Silicon, `aarch64-darwin`) for personal and work use.

Notes:

- Unified configuration for personal and work.
- Home Manager config sets `home.username = "luis"` and `home.homeDirectory = "/Users/luis"`.

Run:

```sh
home-manager build --flake .#personal-macbook
home-manager switch --flake .#personal-macbook
```
