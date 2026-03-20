# boxes

Nix flake managing system (nix-darwin) and user (home-manager) configuration.

## Structure

- `flake.nix` — Flake entrypoint. Uses flake-parts.
- `boxes/<machine>/` — Per-machine configs (darwin + home-manager)
- `boxes/kojibook/` — aarch64-darwin (Apple Silicon Mac, standard Nix)
- `boxes/yoyo/` — aarch64-darwin (Apple Silicon Mac, Determinate Nix)
- `home/` — Shared home-manager config, imported by each machine's `home.nix`
- `home/programs/` — One file per program (e.g., `tmux.nix`, `git.nix`), aggregated in `default.nix`
- `home/programs/nvim/` — Nixvim config (has its own directory)

## Conventions

- One program per `.nix` file in `home/programs/`
- New programs must be added to `home/programs/default.nix` imports
- Uses nixpkgs unstable channel

## Bootstrapping a new machine

1. Install [Determinate Nix](https://determinate.systems/nix-installer/)
2. Install [Homebrew](https://brew.sh/)
3. `brew install git`
4. Add SSH key (e.g., from Bitwarden or copy from existing machine)
5. Clone this repo
6. `brew tap d12frosted/emacs-plus` (nix-darwin may not handle taps on first bootstrap)
7. `sudo nix run nix-darwin -- switch --flake .#<hostname>`
8. Open new shell, then `NIXPKGS_ALLOW_UNFREE=1 nix run home-manager -- switch --flake . --impure`

## Applying changes

```sh
home-rebuild        # home-manager config
sudo mac-rebuild    # system config (nix-darwin)
```
