{
  inputs,
  nixpkgs,
  nix-darwin,
  home-manager,
  # nixvim,
  vars,
  ...
}:

let
  systemConfig = system: {
    system = system;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{
  MBPBrilliant =
    let
      inherit (systemConfig "aarch64-darwin") system pkgs;
    in
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit
          inputs
          system
          pkgs
          vars
          ;
      };
      modules = [
        ./configuration.nix

        # nixvim.nixDarwinModules.nixvim

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
}
