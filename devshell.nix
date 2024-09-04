{ pkgs, ... }:
{

  env = [ ];
  commands = [
    {
      name = "mac-update";
      command = ''
        if [ $# -lt 1 ]; then
          echo 1>&2 "Config name missing"
          exit 2
        fi

        darwin-rebuild switch --flake .#$1 --show-trace
      '';
      help = "mac-update <name-of-config>";
    }
  ];
  packages = with pkgs; [
    nixfmt-rfc-style
    nil
  ];
}
