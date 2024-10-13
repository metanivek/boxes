{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;

      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffer";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "Code";
          }
          {
            __unkeyed-1 = "<leader>k";
            group = "Command";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "File";
          }
          {
            __unkeyed-1 = "<leader>p";
            group = "Project";
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "Quit/Session";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Search";
          }
          {
            __unkeyed-1 = "<leader>o";
            group = "Toggle";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "Window";
          }
        ];
      };
    };
  };
}
