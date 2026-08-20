{
  config,
  herdrColliePackage,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  herdrPackage = inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;
  configDir = "${config.home.homeDirectory}/.config/herdr/plugins/config/herdr.collie";
  stateDir = "${config.xdg.stateHome}/herdr.collie";
  runtimePath =
    lib.makeBinPath [
      pkgs.bash
      pkgs.bun
      pkgs.coreutils
      pkgs.gawk
      pkgs.git
      pkgs.gnused
      herdrPackage
      pkgs.tailscale
    ]
    + ":/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin";
in
{
  home.packages = [ herdrColliePackage ];

  home.activation.herdrCollieConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_dir="${configDir}"
    env_file="$config_dir/.env"
    ${pkgs.coreutils}/bin/mkdir -p "$config_dir"
    umask 077
    tmp_file="$(${pkgs.coreutils}/bin/mktemp "$config_dir/.env.XXXXXX")"
    if [ -f "$env_file" ]; then
      ${pkgs.gawk}/bin/awk \
        -v runtime_path='${runtimePath}' \
        '
          /^(export[[:space:]]+)?COLLIE_VAPID_(PUBLIC|PRIVATE|SUBJECT)=/ { print; next }
          /^(export[[:space:]]+)?(COLLIE_HOST|COLLIE_PORT|COLLIE_SERVE_MODE|COLLIE_TRUSTED_USER|COLLIE_PUBLIC_HOSTS|COLLIE_AUDIT_CONTENT|COLLIE_STATE_DIR|PATH)=/ { next }
          { print }
          END {
            print "COLLIE_HOST=127.0.0.1"
            print "COLLIE_PORT=8787"
            print "COLLIE_SERVE_MODE=https"
            print "COLLIE_TRUSTED_USER=kevin.smith@brilliant.org"
            print "COLLIE_PUBLIC_HOSTS=yoyo.tailfcf7e.ts.net"
            print "COLLIE_AUDIT_CONTENT=none"
            print "COLLIE_STATE_DIR=${stateDir}"
            print "PATH=" runtime_path
          }
        ' "$env_file" > "$tmp_file"
    else
      ${pkgs.coreutils}/bin/cat > "$tmp_file" <<EOF
    COLLIE_HOST=127.0.0.1
    COLLIE_PORT=8787
    COLLIE_SERVE_MODE=https
    COLLIE_TRUSTED_USER=kevin.smith@brilliant.org
    COLLIE_PUBLIC_HOSTS=yoyo.tailfcf7e.ts.net
    COLLIE_AUDIT_CONTENT=none
    COLLIE_STATE_DIR=${stateDir}
    PATH=${runtimePath}
    EOF
    fi
    ${pkgs.coreutils}/bin/chmod 600 "$tmp_file"
    ${pkgs.coreutils}/bin/mv "$tmp_file" "$env_file"
  '';

  home.activation.herdrColliePlugin = lib.hm.dag.entryAfter [ "herdrCollieConfig" ] ''
    collie_started=0
    if /bin/launchctl print "gui/$(${pkgs.coreutils}/bin/id -u)/herdr.collie" >/dev/null 2>&1; then
      collie_started=1
    fi

    ${lib.getExe herdrPackage} plugin link "${herdrColliePackage}"

    if [ "$collie_started" -eq 1 ]; then
      /bin/bash "${herdrColliePackage}/scripts/collie-ctl.sh" restart
    fi
  '';
}
