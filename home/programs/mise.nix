{
  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        go = "latest";
        node = "20";
        opam = "latest";
        python = "latest";
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
