{ inputs, rev, ... }:
let
  username = "metanivek";
  inherit (inputs) nixpkgs;
  inherit (inputs.nix-darwin.lib) darwinSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{

  darwinConfigurations.kojibook = darwinSystem {
    specialArgs = {
      inherit username;
    };
    modules = [
      ./configuration.nix
      {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.hostPlatform = "aarch64-darwin";
        system.configurationRevision = rev;
      }
    ];
  };

  homeConfigurations.${username} = homeManagerConfiguration {
    pkgs = import nixpkgs {
      system = "aarch64-darwin";
      config.allowUnfree = true;
    };
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
