# AGENTS.md

High-signal notes for OpenCode sessions working in this Home Manager flake.

## Build / Verify

Preferred order of verification

1. Flake checks: `nix flake check`
2. Dry-run activation: `home-manager switch --flake .#personal-macbook --dry-run`
3. Build (no activation): `home-manager build --flake .#personal-macbook`
4. Activate: `home-manager switch --flake .#personal-macbook`

Host names (use these): `personal-macbook`, `secured-macbook`, `secured-linux`, `wsl`.

## Repo Structure (Dendritic)

- `flake.nix` is intentionally minimal and imports everything under `modules/` via `import-tree`.
- Home Manager “features” are aspects published as `flake.modules.homeManager.<aspect>` in `modules/**/default.nix`.
- Hosts are defined as `flake.homeConfigurations.<name>` in `modules/hosts/*/default.nix` and composed by listing aspects.

Wiring convention that’s easy to miss:

- `modules/inputs.nix` defines an aspect `hm.inputs` that sets `_module.args.inputs = inputs`.
- Hosts include `hm.inputs` first so other aspects can reference `inputs` without `extraSpecialArgs`.

## Nix Style

- Indentation: 2 spaces.
- Formatter: `nixfmt` (repo includes `pkgs.nixfmt`).
- Naming: kebab-case filenames; camelCase attr/var names.
- Prefer relative imports within an aspect directory.

## Tooling Quirks

- macOS hosts import nixpkgs with `inputs.emacs-lsp-booster.overlays.default`; keep that overlay if using `pkgs.emacs-lsp-booster`.
- Doom Emacs aspect is in `modules/editor/doomemacs/default.nix`.
  - Doom config is linked to `~/.config/doom` from `modules/editor/doomemacs/doom`.
  - Doom’s bin path is added to `PATH` as `~/.config/emacs/bin`.
  - macOS Emacs itself is expected to be installed out-of-band (see `modules/editor/doomemacs/README.md`).
