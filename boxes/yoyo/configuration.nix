{
  pkgs,
  config,
  username,
  ...
}:
{
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    aspell
    ast-grep
    colima
    cmake
    docker
    docker-compose
    dust
    editorconfig-core-c
    entr
    gawk
    gh
    fd
    flyctl
    fswatch
    graphviz
    home-manager
    jq
    just
    k9s
    kubectl
    kubernetes-helm
    ranger
    shellcheck
    sops
    tree-sitter
  ];

  environment.etc = {
    # store list of installed packages for quick reference
    "current-system-packages".text =
      let
        packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
        sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
      formatted;
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  homebrew = {
    enable = true;
    onActivation = {
      # handle updates/upgrades with brew outside of nix
      autoUpdate = false;
      upgrade = false;
      cleanup = "none"; # "zap"
    };
    taps = [
      "anomalyco/tap"
      "d12frosted/emacs-plus"
    ];
    brews = [
      "ast-grep"
      # TODO can i manage emacs with nix?
      "emacs-plus@30"
      # libtool is required to build vterm in emacs
      # TODO figure out how to manage this with nix
      "libtool"
      "anomalyco/tap/opencode"
      "pinentry-mac"
    ];
    casks = [
      "1password-cli"
      "alacritty"
      "bitwarden"
      "claude-code@latest"
      "codex"
      "font-blex-mono-nerd-font"
      "font-fira-code"
      "font-fira-code-nerd-font"
      "font-hack-nerd-font"
      "font-iosevka-nerd-font"
      "ghostty"
      "hiddenbar"
      "iterm2"
      "raycast"
      "swiftbar"
      "tailscale-app"
    ];
    masApps = { };
  };

  # Determinate Nix manages itself
  nix.enable = false;

  system = {
    # apparently stuff is migrating aspects of darwin-rebuild but
    # this is the workaround until that is complete
    primaryUser = username;

    # Used for backwards compatibility, check changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.swipescrolldirection" = false; # disable natural scroll
        "com.apple.trackpad.enableSecondaryClick" = true;
      };

      dock = {
        autohide = true;
        magnification = false;
        mineffect = "scale";
        minimize-to-application = true;
        orientation = "left";
        showhidden = false;
        show-recents = false;
        tilesize = 44;
        wvous-bl-corner = 3; # application windows
        wvous-br-corner = 2; # mission control
        wvous-tl-corner = 4; # desktop
        wvous-tr-corner = 12; # notification center
      };

      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false; # no icons on desktop
        FXDefaultSearchScope = "SCcf"; # search current folder
        FXPreferredViewStyle = "clmv"; # column view
        ShowPathbar = false;
        ShowStatusBar = true;
      };

      CustomUserPreferences = {
        "com.apple.finder" = {
          # Set home directory as startup window and new window target
          NewWindowTargetPath = "file:///Users/${username}/";
          NewWindowTarget = "PfHm";
          # Multi-file tab view
          FinderSpawnTab = true;
        };
        "com.apple.desktopservices" = {
          # Disable creating .DS_Store files in network an USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Disable "Select previous input source" (Ctrl+Space) — tmux leader
            "60" = {
              enabled = false;
              value = {
                parameters = [
                  32
                  49
                  262144
                ];
                type = "standard";
              };
            };
            # Disable "Select next input source" (Ctrl+Cmd+Space) — Raycast emoji picker
            "61" = {
              enabled = false;
              value = {
                parameters = [
                  32
                  49
                  786432
                ];
                type = "standard";
              };
            };
            # Disable "Show Spotlight Search" (Cmd+Space) — Raycast launcher
            "64" = {
              enabled = false;
              value = {
                parameters = [
                  65535
                  49
                  1048576
                ];
                type = "standard";
              };
            };
          };
        };
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      };
    };
  };
}
