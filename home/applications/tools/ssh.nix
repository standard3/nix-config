{
  programs.ssh = {
    enable = true;
    # addKeysToAgent = "yes";

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_rsa";
      };

      "pwn.college" = {
        hostname = "pwn.college";
        user = "hacker";
        identityFile = "~/.ssh/pwn.college";
      };

      "git.ecole2600.com" = {
        hostname = "git.ecole2600.com";
        identityFile = "~/.ssh/2600";
      };
    };
  };
}
