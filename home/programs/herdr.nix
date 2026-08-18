{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  package = inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
    };

    terminal = {
      shell_mode = "auto";
      new_cwd = "follow";
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
      accent = "green";
      sound.enabled = false;
      toast.delivery = "system";
    };

    advanced.scrollback_limit_bytes = 10000000;
    update.version_check = false;
  };
in
{
  home.packages = [ package ];

  xdg.configFile."herdr/config.toml" = {
    source = tomlFormat.generate "herdr-config.toml" settings;
    onChange = "${lib.getExe package} server reload-config || true";
  };
}
