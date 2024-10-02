{
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local config = wezterm.config_builder()

      config.color_scheme = "Kanagawa (Gogh)"

      config.font = wezterm.font "FiraCode Nerd Font Mono"
      config.font_size = 16

      config.hide_tab_bar_if_only_one_tab = true

      return config
    '';
  };
}
