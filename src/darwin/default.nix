{
  nix-darwin,
  home-manager,
  vars,
  ...
}:

{
  koji = nix-darwin.lib.darwinSystem {
    specialArgs = {
      hostPlatform = "aarch64-darwin";
      shellExtra = ''
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

      inherit vars;
    };

    modules = [
      ./configuration.nix

      home-manager.darwinModules.home-manager
      ../home
    ];
  };
}
