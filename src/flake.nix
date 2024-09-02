{
  description = "📦";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      vars = {
        rev = self.rev or self.dirtyRev or null;
        user = "metanivek";
        location = "$HOME/.boxes";
        terminal = "alacritty";
        editor = "vim";
      };
    in

    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      flake = {
        darwinConfigurations = (
          import ./darwin {
            inherit (nixpkgs) lib;
            inherit
              inputs
              nixpkgs
              home-manager
              nix-darwin
              vars
              ;
          }
        );
      };

      # perSystem = { config, pkgs, ... } { };
    };
}
