{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
    };
    plugins.treesitter-context = {
      enable = true;
      settings = {
        max_lines = 5;
        mode = "topline";
        multiline_threshold = 1;
        trim_scope = "outer";
      };
    };
    plugins.treesitter-refactor = {
      enable = true;
      # navigation.enable = true;
    };
  };
}
