{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.ssh/host_config" ];

    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_ed25519";
        addKeysToAgent = "yes";
        forwardAgent = true;

        # defaults
        compression = false;
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
        hashKnownHosts = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
    };
  };
}
