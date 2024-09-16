{ ... }:
let
  mkKeymap =
    {
      mode ? "n",
      key,
      action,
      desc ? "",
    }:
    {
      inherit mode key action;
      options = {
        noremap = true;
        silent = true;
        inherit desc;
      };
    };

  keymaps = [
    # window mgmt
    {
      key = "<leader>ws";
      action = "<C-W>s";
      desc = "Split window below";
    }
    {
      key = "<leader>wv";
      action = "<C-W>v";
      desc = "Split window right";
    }
    {
      key = "<leader>wc";
      action = "<C-W><C-Q>";
      desc = "Close window";
    }
    {
      key = "<leader>wj";
      action = "<C-W>j";
      desc = "Focus window down";
    }
    {
      key = "<leader>wh";
      action = "<C-W>h";
      desc = "Focus window left";
    }
    {
      key = "<leader>wk";
      action = "<C-W>k";
      desc = "Focus window up";
    }
    {
      key = "<leader>wl";
      action = "<C-W>l";
      desc = "Focus window right";
    }
    # directory hopping
    {
      key = "<leader>.";
      action = "<cmd>:Ex<cr>";
      desc = "Explore current directory";
    }
    # buffer mgmt
    {
      key = "<leader>bk";
      action = "<cmd>bd<cr>";
      desc = "Close buffer";
    }
    {
      key = "<leader>bN";
      action = "<cmd>:enew<cr>";
      desc = "New empty buffer";
    }
    {
      key = "<leader>bn";
      action = "<cmd>bn<cr>";
      desc = "Next buffer";
    }
    {
      key = "<leader>bp";
      action = "<cmd>bp<cr>";
      desc = "Previous buffer";
    }
    # save
    {
      key = "<leader>fs";
      action = "<cmd>w<cr><esc>";
      desc = "Save file";
    }
    # quit
    {
      key = "<leader>qq";
      action = "<cmd>confirm quitall<cr><esc>";
      desc = "Quit all";
    }
  ];
in
{
  programs.nixvim = {
    keymaps = map mkKeymap keymaps;
  };
}
