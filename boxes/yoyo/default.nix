{ inputs, rev, ... }:
let
  username = "metanivek";
  inherit (inputs) nixpkgs;
  inherit (inputs.nix-darwin.lib) darwinSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
in
{
  darwinConfigurations.yoyo = darwinSystem {
    inherit pkgs;
    specialArgs = {
      inherit username;
    };
    modules = [
      ./configuration.nix
      {
        nixpkgs.hostPlatform = system;
        system.configurationRevision = rev;
      }
    ];
  };

  homeConfigurations."${username}@yoyo" = homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      inherit username;
      inherit inputs;
    };
    modules = [
      ./home.nix
      {
        home = {
          inherit username;
          homeDirectory = "/Users/${username}";
        };
      }
    ];
  };
}
