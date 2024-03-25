{
  programs.ssh = {
    enable = true;
    startAgent = true;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_rsa";
      };

      "pwn.college" = {
        hostname = "pwn.college";
        user = "hacker";
        identityFile = "~/.ssh/id_rsa";
      };

      "git.ecole2600.com" = {
        hostname = "git.ecole2600.com";
        identityFile = "~/.ssh/pwn.college";
      };
    };
  };
}
