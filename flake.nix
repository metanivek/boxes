{
  description = "📦";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    herdr.url = "github:herdrdev/herdr/v0.8.0";
    herdr-plugin-gh-pr = {
      url = "github:wyattjoh/herdr-plugin-gh-pr/v0.4.0";
      flake = false;
    };
    herdr-automatic-rename = {
      url = "github:qu8n/herdr-automatic-rename/v0.7.2";
      flake = false;
    };
    herdr-nvim = {
      url = "github:ChmaraX/herdr-nvim/40aadeab3cef3702ef5e05069181c7168084794f";
      flake = false;
    };
    collie = {
      url = "github:AltanS/collie/v0.32.0";
      flake = false;
    };
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
          packages.herdr-collie = pkgs.callPackage ./packages/herdr-collie.nix { src = inputs.collie; };
          devshells.default = lib.importTOML ./devshell.toml;
        };

      flake =
        let
          args = {
            inherit inputs;
            inherit rev;
          };
          kojibook = import ./boxes/kojibook args;
          yoyo = import ./boxes/yoyo (
            args
            // {
              herdrColliePackage = self.packages.aarch64-darwin.herdr-collie;
            }
          );
        in
        {
          darwinConfigurations = kojibook.darwinConfigurations // yoyo.darwinConfigurations;
          homeConfigurations = kojibook.homeConfigurations // yoyo.homeConfigurations;
        };
    };
}
