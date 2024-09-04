{
  description = "📦";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.url = "github:lnl7/nix-darwin";
    devshell.url = "github:numtide/devshell";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
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

      imports = [ inputs.devshell.flakeModule ];

      perSystem =
        { config, pkgs, ... }:
        {
          devshells.default = import ./devshell.nix;
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
