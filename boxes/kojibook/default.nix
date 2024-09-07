{
  nix-darwin,
  home-manager,
  rev,
  ...
}:

nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit home-manager;
    username = "metanivek";
  };

  modules = [
    ./configuration.nix
    ./home.nix
    { system.configurationRevision = rev; }
  ];
}
