{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;

      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>w";
            group = "Windows";
          }
        ];
      };
    };
  };
}
