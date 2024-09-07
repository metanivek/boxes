{ username, home-manager, ... }:

{
  imports = [
    home-manager.darwinModules.home-manager
    ../../home
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  home-manager.users.${username} = {
    programs.zsh = {
      antidote.plugins = [ "jscutlery/nx-completion" ];
      initExtra = ''
        # homebrew
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # use homebrew's gnu grep
        export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"

        export BDEVTOOLS=$HOME/b/developer-tools
        alias google-login='just -d $BDEVTOOLS -f $BDEVTOOLS/justfile google'
        alias google-config='just -d $BDEVTOOLS -f $BDEVTOOLS/justfile googleconfig'
        alias ecr-login='just -d $BDEVTOOLS -f $BDEVTOOLS/justfile ecr-login'
        alias kubeconfig='just -d $BDEVTOOLS -f $BDEVTOOLS/justfile kubeconfig'
      '';
    };

    programs.mise.globalConfig.tools = {
      postgres = "14.10";
    };

    programs.git = {
      signing.key = "95543858";
      includes = [
        {
          contents.user = {
            email = "kevin.smith@brilliant.org";
            signingKey = "4AD405B2E937FB58";
          };
          condition = "gitdir:~/b/";
        }
      ];
    };

    home.file.".gnupg/gpg-agent.conf".text = ''
      pinentry-program /opt/homebrew/bin/pinentry-mac
    '';
  };
}
