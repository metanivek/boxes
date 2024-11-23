{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      settings = {
        auto_install = true;
        ensure_installed = [
          "bash"
          "c"
          "clojure"
          "cpp"
          "css"
          "csv"
          "diff"
          "dockerfile"
          "dot"
          "elixir"
          "elm"
          "erlang"
          "fennel"
          "fsh"
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
          "gleam"
          "go"
          "gomod"
          "graphql"
          "haskell"
          "hcl"
          "helm"
          "html"
          "hurl"
          "javascript"
          "json"
          "json5"
          "just"
          "kotlin"
          "lua"
          "luadoc"
          "make"
          "markdown"
          "nginx"
          "nix"
          "ocaml"
          "ocaml_interface"
          "python"
          "rust"
          "sql"
          "swift"
          "terraform"
          "toml"
          "typescript"
          "vue"
          "xml"
          "yaml"
          "zig"
        ];
        highlight = {
          enable = true;
        };
        incremental_selection = {
          enable = true;

          keymaps = {
            init_selection = "gnn";
            node_decremental = "grm";
            node_incremental = "grn";
            scope_incremental = "grc";
          };
        };

        indent = {
          enable = true;
        };
      };
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
