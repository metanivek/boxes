{
  programs.nixvim = {
    plugins.gitsigns.enable = true;

    plugins.neogit = {
      enable = true;
      settings = {
        kind = "floating";
        commit_popup.kind = "floating";
        preview_buffer.kind = "floating";
        popup.kind = "floating";
      };
    };
  };
}
