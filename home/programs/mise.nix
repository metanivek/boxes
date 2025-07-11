{
  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        node = "20";
        python = "latest";
        go = "latest";
        rust = "1.88.0";
        "cargo:https://github.com/kejadlen/jj" = {
          bin = "jj";
          version = "branch:lfs";
          crate = "jj-cli";
        };
      };
    };
  };
}
