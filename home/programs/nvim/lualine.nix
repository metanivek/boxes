{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        extensions = [ "fzf" ];
        sections.lualine_c = [
          {
            __unkeyed-1 = "filename";
            path = 4;
          }
        ];
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
