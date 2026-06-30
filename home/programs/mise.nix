{
  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        go = "latest";
        node = "24";
        opam = "latest";
        python = "latest";
        rust = "latest";
        bun = "latest";
      };
    };
  };
}
