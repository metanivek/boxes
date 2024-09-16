{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        extensions = [ "fzf" ];
        theme = "auto";
        options = {
          component_separators = {
            left = "|";
            right = "|";
          };
          section_separators = {
            left = "█"; # 
            right = "█"; # 
          };
          ignore_focus = [ "neo-tree" ];
        };
      };
    };
  };
}
