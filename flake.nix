{
  description = "📦";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    herdr.url = "github:herdrdev/herdr/v0.8.0";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      home-manager,
      nixpkgs,
      devshell,
      ...
    }:

    let
      rev = self.rev or self.dirtyRev or "dirty";
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

      flake =
        let
          args = {
            inherit inputs;
            inherit rev;
          };
          kojibook = import ./boxes/kojibook args;
          yoyo = import ./boxes/yoyo args;
        in
        {
          darwinConfigurations = kojibook.darwinConfigurations // yoyo.darwinConfigurations;
          homeConfigurations = kojibook.homeConfigurations // yoyo.homeConfigurations;
        };
    };
}
