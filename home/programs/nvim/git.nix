{
  programs.nixvim = {
    plugins.gitsigns.enable = true;

    plugins.gitblame = {
      enable = true;
      settings = {
        enabled = false;
      };
    };

    plugins.gitmessenger = {
      enable = true;
      includeDiff = "current";
    };

    plugins.neogit = {
      enable = true;
      settings = {
        kind = "replace";
        commit_popup.kind = "replace";
        preview_buffer.kind = "replace";
        popup.kind = "replace";
      };
    };

    keymaps = [
      {
        key = "<leader>gB";
        action = "<cmd>GitBlameToggle<cr>";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle git blame";
        };
      }
      {
        key = "<leader>gg";
        action = "<cmd>Neogit<cr>";
        options = {
          noremap = true;
          silent = true;
          desc = "Open Neogit";
        };
      }
    ];
  };
}
