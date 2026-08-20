# This is a Herdr plugin root, not a conventional executable package:
# `herdr plugin link` consumes the resulting directory directly.
{
  pkgs,
  src,
}:
let
  # Collie has two Bun lockfiles, and nixpkgs has no Bun dependency
  # fetch/build helper. This fixed-output derivation therefore allows the
  # network; its hash covers installed dependencies and the built frontend.
  # To update it, set a fake hash, build, copy the reported "got" hash here,
  # then rebuild.
  # Source bumps require reviewing replacement anchors and updating the
  # version, timestamp/pin as appropriate, flake input, and output hash together.
  collieBuild = pkgs.stdenv.mkDerivation {
    pname = "herdr-collie";
    version = "0.32.0";
    inherit src;
    dontUnpack = true;
    dontFixup = true;

    nativeBuildInputs = [ pkgs.bun ];

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "gbQHXa1J0U3Re2OF85BycbGBB3W20shry891CF309+o=";
    __structuredAttrs = true;

    buildPhase = ''
        runHook preBuild
        cp -R "$src"/. .
        chmod -R u+w .

        # Replace cmd_build and cmd_update because the store is immutable and
        # updates are managed by the flake. Start can still run because
        # web/dist is built into this plugin root.
        substituteInPlace scripts/collie-ctl.sh \
          --replace-fail '    /usr/bin/bun; do' '    /usr/bin/bun \
      "__COLLIE_BUN__"; do'
        substituteInPlace scripts/collie-ctl.sh \
          --replace-fail 'cmd_build() {' 'cmd_build_original() {' \
          --replace-fail 'ensure_build() {' 'cmd_build() {
          echo "frontend is Nix-built; no-op"
        }

        ensure_build() {' \
          --replace-fail 'cmd_update() {' 'cmd_update_original() {' \
          --replace-fail 'refresh_registry() {' 'cmd_update() {
          echo "Collie updates are managed by the Nix flake; no checkout or dependency changes made."
        }

        refresh_registry() {'
        # Upstream embeds the current time in the bundle/build-info, so pin it
        # to keep the fixed-output build reproducible.
        substituteInPlace web/vite.config.ts \
          --replace-fail 'const buildTime = new Date().toISOString();' \
          'const buildTime = "2026-08-19T00:00:00.000Z";'

        export HOME="$TMPDIR/home"
        mkdir -p "$HOME"
        bun install --frozen-lockfile
        (cd web && bun install --frozen-lockfile)
        bun run typecheck
        (cd web && bun run typecheck)
        (cd web && bun run build)
        rm -rf web/node_modules web/dist-staging web/tsconfig.tsbuildinfo ./.??*node-gyp env-vars "$HOME"
        runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      rm -rf env-vars .attrs.json .attrs.sh
      mkdir -p "$out"
      cp -R ./. "$out/"
      runHook postInstall
    '';
  };
in
pkgs.runCommand "herdr-collie-plugin" { } ''
  mkdir -p "$out"
  cp -R ${collieBuild}/. "$out/"
  # launchd and Herdr actions provide a minimal PATH, so the script must use
  # the exact Bun path from this Nix build.
  substituteInPlace "$out/scripts/collie-ctl.sh" \
    --replace-fail "__COLLIE_BUN__" "${pkgs.bun}/bin/bun"
  # On macOS, bootstrap can leave the agent loaded with runs=0 and no
  # listener. A non-`-k` kickstart starts it without restarting a running job.
  substituteInPlace "$out/scripts/collie-ctl.sh" \
    --replace-fail '    [ "$supervised" = 0 ] || echo "bridge started (launchd: ''${AGENT_LABEL})"' \
    '    if [ "$supervised" != 0 ]; then
      if ! launchctl kickstart "$(launchd_target)"; then
        echo "error: launchd kickstart failed for $(launchd_target)" >&2
        return 1
      fi
      echo "bridge started (launchd: ''${AGENT_LABEL})"
    fi'
  grep -F 'launchctl kickstart "$(launchd_target)"' "$out/scripts/collie-ctl.sh" >/dev/null
  grep -F 'error: launchd kickstart failed' "$out/scripts/collie-ctl.sh" >/dev/null
''
