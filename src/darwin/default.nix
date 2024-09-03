{
  nix-darwin,
  home-manager,
  vars,
  ...
}:

{
  # work mbp
  koji = nix-darwin.lib.darwinSystem {
    # arguments to pass to modules
    specialArgs = {
      hostPlatform = "aarch64-darwin";
      inherit vars;
    };

    modules = [
      ./configuration.nix

      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
