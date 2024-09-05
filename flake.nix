{
  description = "📦";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      devshell,
      ...
    }:

    let
      vars = {
        rev = self.rev or self.dirtyRev or "dirty";
        user = "metanivek";
        editor = "vim";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      imports = [ devshell.flakeModule ];

      perSystem =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          devshells.default = lib.importTOML ./devshell.toml;
        };

      flake = {
        darwinConfigurations = {
          kojibook = import ./hosts/kojibook {
            inherit (nixpkgs) lib;
            inherit (inputs) home-manager nix-darwin;
            inherit vars;
          };
        };
      };
    };
}
