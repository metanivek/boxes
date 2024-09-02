{
  description = "📦 dev env";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      imports = [ inputs.devshell.flakeModule ];

      perSystem =
        { config, pkgs, ... }:
        {
          devshells.default = {
            env = [ ];
            commands = [
              {
                package = "nixfmt-rfc-style";
                category = "Formatters";
              }
              {
                name = "lock";
                category = "Utils";
                help = "Generates flake.lock";
                command = "nix flake lock";
              }
            ];
            packages = with pkgs; [ nil ];
          };
        };
    };
}
