{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        extensions = [ "fzf" ];
        sections.lualine_a = [
          {
            __unkeyed-1 = "mode";
            fmt.__raw = ''
              function(str) return str:sub(1,1) end
            '';
          }
        ];
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
            left = ""; # "█"; # 
            right = ""; # "█"; # 
          };
          ignore_focus = [ "neo-tree" ];
        };
      };
    };
  };
}
