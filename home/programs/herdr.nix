{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  herdrPackage = inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;
  herdrGhPrPlugin = inputs.herdr-plugin-gh-pr;
  herdrAutomaticRenamePlugin = inputs.herdr-automatic-rename;
  herdrNvimPackage = pkgs.rustPlatform.buildRustPackage {
    pname = "herdr-nvim";
    version = "0.1.1";
    src = inputs.herdr-nvim;

    cargoLock.lockFile = "${inputs.herdr-nvim}/Cargo.lock";
    cargoHash = "sha256-qGR4BXZCudZVUUik/f9U3NPM5xW1L3bWQaZXCmADZGM=";
    doCheck = false;
  };
  pluginRoot = pkgs.runCommand "herdr-nvim-plugin" { } ''
    mkdir -p "$out"
    cp -R ${inputs.herdr-nvim}/. "$out/"
    install -Dm755 ${herdrNvimPackage}/bin/herdr-nvim "$out/bin/herdr-nvim"
  '';
  tomlFormat = pkgs.formats.toml { };
  settings = {
    onboarding = false;

    keys = {
      prefix = "ctrl+space";
      reload_config = "prefix+r";
      settings = "prefix+shift+s";
      split_vertical = "prefix+v";
      split_horizontal = "prefix+s";
      focus_pane_left = "ctrl+h";
      focus_pane_down = "ctrl+j";
      focus_pane_up = "ctrl+k";
      focus_pane_right = "ctrl+l";
      rename_tab = "prefix+n";
      new_tab = "prefix+c";
      next_tab = "prefix+]";
      workspace_picker = "prefix+g";
      goto = "prefix+space";
      resize_mode = "prefix+shift+r";
      toggle_sidebar = "prefix+t";
      copy_mode = "prefix+[";
      command = [
        {
          key = "prefix+e";
          type = "plugin_action";
          command = "chmarax.herdr-nvim.toggle";
          description = "nvim sidebar";
        }
        {
          key = "prefix+o";
          type = "plugin_action";
          command = "chmarax.herdr-nvim.pick-file";
          description = "open file from agent output";
        }
        {
          key = "prefix+u";
          type = "plugin_action";
          command = "gh-pr.open-pr";
          description = "open PR in browser";
        }
        {
          key = "prefix+i";
          type = "plugin_action";
          command = "gh-pr.refresh";
          description = "refresh PR status";
        }
      ];
    };

    terminal = {
      shell_mode = "auto";
      new_cwd = "follow";
    };

    theme = {
      name = "terminal";
    };

    ui = {
      mouse_capture = true;
      copy_on_select = true;
      tab_bar_position = "bottom";
      prompt_new_tab_name = false;
      pane_borders = true;
      pane_gaps = true;
      pane_scrollbars = false;
      sidebar_start_collapsed = true;
      sidebar_collapsed_mode = "hidden";
      sidebar = {
        agents = {
          rows = [
            [
              "state_icon"
              "workspace"
            ]
            [
              "$pr"
              "state_text"
            ]
          ];
        };
        spaces = {
          row_gap = 0;
          rows = [
            [
              "state_icon"
              "workspace"
            ]
            [
              "git_status"
            ]
          ];
        };
      };
      accent = "green";
      sound.enabled = false;
      toast.delivery = "system";
    };

    advanced.scrollback_limit_bytes = 10000000;
    update.version_check = false;
  };

  nvimConfig = {
    sidebar = {
      nvim_bin = lib.getExe config.programs.nixvim.build.package;
      position = "right";
    };
    picker = {
      scan_lines = 300;
      max_files = 20;
    };
  };
in
{
  home.packages = [
    herdrPackage
    pkgs.bun
    pkgs.gh
    pkgs.jq
  ];

  home.activation.herdrGhPrPlugin = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${lib.getExe herdrPackage} plugin link ${herdrGhPrPlugin}
  '';

  home.activation.herdrNvimPlugin = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${lib.getExe herdrPackage} plugin link ${pluginRoot}
  '';

  home.activation.herdrAutomaticRenamePlugin = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${lib.getExe herdrPackage} plugin link ${herdrAutomaticRenamePlugin}
  '';

  programs.zsh.initContent = lib.mkAfter ''
    source ${herdrAutomaticRenamePlugin}/shell/hook.zsh
  '';

  xdg.configFile."herdr/config.toml" = {
    source = tomlFormat.generate "herdr-config.toml" settings;
    onChange = "${lib.getExe herdrPackage} server reload-config || true";
  };

  xdg.configFile."herdr-nvim/config.toml" = {
    source = tomlFormat.generate "herdr-nvim-config.toml" nvimConfig;
  };
}
