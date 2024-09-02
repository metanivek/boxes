{ pkgs, vars, ... }:

{
  # imports = (import ./modules);

  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  environment = {
    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      # antidote # need to figure out how to hook into .zshrc
      aspell
      bat
      colima
      cmake
      direnv
      docker
      docker-compose
      dust
      editorconfig-core-c
      gawk
      eza
      fd
      flyctl
      fswatch
      fzf
      git
      git-absorb
      git-lfs
      gnupg
      graphviz
      jq
      just
      k9s
      kubectl
      kubernetes-helm
      neovim
      ranger
      ripgrep
      shellcheck
      sops
      tmux
      tree-sitter
      z-lua
      # zsh-powerlevel10k
    ];
  };

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      # handle updates/upgrades with brew outside of nix
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    taps = [ "d12frosted/emacs-plus" ];
    brews = [
      "antidote"
      "ca-certificates"
      "emacs-plus@29"
      "pinentry-mac"
      "python@3.11"
    ];
    casks = [
      "1password-cli"
      "alacritty"
      "font-blex-mono-nerd-font"
      "font-fira-code"
      "font-fira-code-nerd-font"
      "font-hack-nerd-font"
      "hiddenbar"
      "iterm2"
      "raycast"
    ];
    masApps = {
      "Xcode" = 497799835;
    };
  };

  home-manager.users.${vars.user} = {
    home.stateVersion = "24.05";
  };

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    # Set Git commit hash for darwin-version.
    configurationRevision = vars.rev;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.trackpad.enableSecondaryClick" = true;
      };
      dock = {
        autohide = true;
        magnification = false;
        mineffect = "scale";
        minimize-to-application = true;
        orientation = "bottom";
        showhidden = false;
        show-recents = false;
        tilesize = 44;
      };
      finder = {
        ShowPathbar = false;
        ShowStatusBar = true;
      };

      CustomUserPreferences = {
        # Settings of plist in ~/Library/Preferences/
        "com.apple.finder" = {
          # Set home directory as startup window
          NewWindowTargetPath = "file:///Users/${vars.user}/";
          NewWindowTarget = "PfHm";
          # Set search scope to directory
          FXDefaultSearchScope = "SCcf";
          # Multi-file tab view
          FinderSpawnTab = true;
        };
        "com.apple.desktopservices" = {
          # Disable creating .DS_Store files in network an USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        # Do not show battery percentage
        "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = false;
        # Privacy
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      };
    };
  };
}
