# AGENTS.md

This file provides essential information for AI agents working in this Home Manager configuration repository.

## 🛠 Build, Lint, and Test Commands

This project uses **Nix**, **Home Manager**, and the **Dendritic** pattern (flake-parts + `flake.modules`).

- `flake.nix` is intentionally minimal.
- All configuration lives under `modules/` as flake-parts modules.
- Home Manager “features” are expressed as aspects in `flake.modules.homeManager.<aspect>`.
- Hosts are composed by selecting a list of aspects.

### Build and Activation
The primary way to test changes is to run a dry-run activation or a full switch.
- **Dry-run (Recommended for testing):** 
  `home-manager build --flake .#macbook` (or `wsl`, `secured-macbook`)
- **Activate changes:**
  `home-manager switch --flake .#macbook`
- **Nix Flake Check (Lint/Verify):**
  `nix flake check`

### Testing Specific Components
Since this is a configuration repo, "tests" are usually successful builds.
- **Dry activation (no changes to system):**
  `home-manager switch --flake .#macbook --dry-run`

## 🎨 Code Style and Guidelines

### 📁 Structure
- `/modules`: Every `.nix` file is a flake-parts module. Subdirectories are allowed and purely organizational.
- `/modules/hosts/home-configurations.nix`: Defines `flake.homeConfigurations` by composing aspects.
- `/modules/base/*`: Base Home Manager aspect 
- `/modules/macos/*`: Shared macOS Home Manager aspect.
- `/flake.nix`: Minimal entry point that enables flake-parts modules + auto-import.

### 📜 Nix Style
- **Indentation:** 2 spaces.
- **Formatting:** Use `nixfmt-rfc-style`.
- **Naming:** Use kebab-case for filenames and camelCase for Nix variables/attributes within files.
- **Imports:** Prefer relative paths for internal imports within an aspect directory.
- **Dendritic Pattern:**
  - Each file under `modules/` contributes to one feature/aspect.
  - Publish Home Manager aspects via `flake.modules.homeManager.<aspect> = { ... }`.
  - Enable features by listing aspects in `modules/hosts/home-configurations.nix`.
  - Avoid `specialArgs`/`extraSpecialArgs` for cross-file sharing; use module-level let-bindings or flake-parts options instead.

### 🐍 Shell and Scripting
- Fish is the primary interactive shell.
- Use `programs.fish.shellAbbrs` for aliases.
- Shell scripts should be defined as Home Manager packages or linked via `home.file`.

### 🛠 Tool Specifics
- **Doom Emacs:** Configuration is managed in `modules/doomemacs/doom`. Use `doom sync` after activation if packages change.
- **NixVim:** Home Manager aspect lives in `modules/nixvim.nix` and imports `inputs.nix2vim.homeModules.nixvim`.
- **Ghostty:** Configured via `xdg.configFile."ghostty/config"`.

## 🤖 AI Interaction Rules
- **Safety First:** Never modify `flake.lock` manually unless requested. Use `nix flake update`.
- **Modularity:** When adding a new feature, add one or more flake-parts modules under `modules/` that contribute to `flake.modules.homeManager.<aspect>`.
- **Dry Runs:** Always suggest or perform a dry-run build after making significant changes to verify the configuration evaluates correctly.

## 🔍 Discovery
If you are unsure where a setting belongs:
1. Search `modules/` for the aspect name (feature-centric paths).
2. Check `modules/hosts/home-configurations.nix` to see which aspects are enabled per host.
3. Keep `flake.nix` minimal; avoid putting configuration logic there.
