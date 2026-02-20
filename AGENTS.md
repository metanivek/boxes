# boxes

Nix flake managing system (nix-darwin) and user (home-manager) configuration.

## Structure

- `flake.nix` — Flake entrypoint. Uses flake-parts.
- `boxes/<machine>/` — Per-machine configs (darwin + home-manager)
- `boxes/kojibook/` — aarch64-darwin (Apple Silicon Mac)
- `home/` — Shared home-manager config, imported by each machine's `home.nix`
- `home/programs/` — One file per program (e.g., `tmux.nix`, `git.nix`), aggregated in `default.nix`
- `home/programs/nvim/` — Nixvim config (has its own directory)

## Conventions

- One program per `.nix` file in `home/programs/`
- New programs must be added to `home/programs/default.nix` imports
- Uses nixpkgs unstable channel

## Applying changes

```sh
home-rebuild        # home-manager config
sudo mac-rebuild    # system config (nix-darwin)
```
