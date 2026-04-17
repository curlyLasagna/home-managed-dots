# Dendritic Migration Plan (Strict)

This repository now follows the strictest interpretation of the Dendritic pattern:

- `flake.nix` is an entry point and stays small.
- Every `.nix` file under `modules/` is a flake-parts module.
- Home Manager configuration is expressed as *aspects* under `flake.modules.homeManager.<aspect>`.
- Hosts are built by selecting a list of aspects.
- No `specialArgs`/`extraSpecialArgs` are used for cross-file communication.
- Flake inputs are made available to Home Manager modules via an aspect that sets `_module.args.inputs`.

## Goals

- Replace host-centric `users/*.nix` with feature/aspect modules.
- Replace Home Manager module directories like `modules/git/default.nix` with flake-parts modules that contribute to `flake.modules.homeManager.*`.
- Auto-import all modules under `./modules` using `import-tree`.
- Keep configuration composition declarative: hosts select aspects; aspects define behavior.

## Implementation Overview

### 1) Minimal `flake.nix`

- Add inputs:
  - `flake-parts`
  - `import-tree`
- Ensure `flake-parts.modules` support is installed via `inputs.flake-parts.flakeModules.modules`.
- Auto-import all `./modules/**/*.nix`.

Key behavior:

```nix
outputs = inputs:
  inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.flake-parts.flakeModules.modules
      (inputs.import-tree ./modules)
    ];
  };
```

### 2) Host composition lives in a module

File: `modules/hosts/home-configurations.nix`

- Defines `flake.homeConfigurations`.
- Each host selects a list of Home Manager aspects from `inputs.self.modules.homeManager`.
- `pkgs` is imported per-host, with overlays and `allowUnfree` applied at import time.

### 3) Base configuration extracted from `users/shared.nix`

Directory: `modules/base/`

- `modules/base/default.nix` publishes the `base` aspect, composed of:
  - `modules/base/nixpkgs.nix` (`allowUnfree`)
  - `modules/base/home.nix` (username, homeDirectory, stateVersion, env vars)
  - `modules/base/packages.nix` (cross-platform CLI packages)
  - `modules/base/programs.nix` (home-manager, direnv, zsh, fzf, helix, zoxide, eza)
  - `modules/base/services.nix` (home-manager autoExpire)

### 4) Shared macOS configuration

Directory: `modules/macos/`

- `modules/macos/default.nix` publishes the `macos` aspect, composed of:
  - `modules/macos/fonts.nix`
  - `modules/macos/session-path.nix`
  - `modules/macos/fish-brew-completions.nix`
  - `modules/macos/git-keychain.nix`

### 5) Personal and Work aspects

- `modules/personal/*` publishes `personal` (GUI apps, latexmkrc, ghcup path)
- `modules/work/*` publishes `work` (work packages, peon-ping, fish abbrs)

### 6) Tool aspects

The previous Home Manager modules under `modules/<tool>/default.nix` are replaced with flake-parts aspects:

- `modules/fish.nix` -> `flake.modules.homeManager.fish`
- `modules/git.nix` -> `flake.modules.homeManager.git`
- `modules/starship.nix` -> `flake.modules.homeManager.starship`
- `modules/lazygit.nix` -> `flake.modules.homeManager.lazygit`
- `modules/lf.nix` -> `flake.modules.homeManager.lf`
- `modules/doomemacs.nix` -> `flake.modules.homeManager.doomemacs`
- `modules/ghostty.nix` -> `flake.modules.homeManager.ghostty`
- `modules/nixvim.nix` -> `flake.modules.homeManager.nixvim` (imports `inputs.nix2vim.homeModules.nixvim`)

### 7) Decommission `users/`

- The `users/*.nix` files are removed.
- Any remaining `users/` directory is non-authoritative; all configuration is under `modules/`.

## How To Add New Configuration

- Create a new file under `modules/` (any nested path is fine).
- Make it a flake-parts module.
- Contribute to an aspect via `flake.modules.homeManager.<aspect>`.
- Add the aspect to a host’s aspect list in `modules/hosts/home-configurations.nix`.

## Validation

Run:

- `nix flake check`
- `home-manager build --flake .#macbook`
- `home-manager build --flake .#secured-macbook`
- `home-manager build --flake .#wsl`

## Notes / Tradeoffs

- `allowUnfree` must be applied where `pkgs` is imported; setting `nixpkgs.config` inside Home Manager does not affect an already-imported `pkgs`.
- Some modules may still exist as Home Manager “program modules” (e.g. `programs.aerospace`) but they are enabled via aspects.
