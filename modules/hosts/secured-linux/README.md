# secured-linux

Powerful Linux desktop (`x86_64-linux`).

Notes:

- Intended for a high-powered workstation.
- Home Manager config sets `home.username = "clark"` and `home.homeDirectory = "/home/clark"`.

Run:

```sh
home-manager build --flake .#secured-linux
home-manager switch --flake .#secured-linux
```
