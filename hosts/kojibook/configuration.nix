{
  pkgs,
  config,
  hostPlatform,
  vars,
  ...
}:

{
  nixpkgs = {
    inherit hostPlatform;
    config = {
      allowUnfree = true;
    };
  };

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
      mise
      neovim
      ranger
      ripgrep
      shellcheck
      sops
      tmux
      tree-sitter
    ];
  };

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
      "d12frosted/emacs-plus"
      "homebrew/services"
    ];
    brews = [
      "ca-certificates"
      "emacs-plus@29"
      "libtool"
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

  services = {
    nix-daemon.enable = true;
    lorri.enable = true;
  };

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
    # Used for backwards compatibility, check changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;

    # Use git commit hash
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
          NewWindowTargetPath = "file:///Users/${vars.user}/";
          NewWindowTarget = "PfHm";
          # Multi-file tab view
          FinderSpawnTab = true;
        };
        "com.apple.desktopservices" = {
          # Disable creating .DS_Store files in network an USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      };
    };
  };
}