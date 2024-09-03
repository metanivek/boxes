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
                name = "mac-update";
                command = ''
                  if [ $# -lt 1 ]; then
                    echo 1>&2 "Config name missing"
                    exit 2
                  fi

                  darwin-rebuild switch --flake ./src#$1 --show-trace
                '';
                help = "mac-update <name-of-config>";
              }
            ];
            packages = with pkgs; [
              nixfmt-rfc-style
              nil
            ];
          };
        };
    };
}
