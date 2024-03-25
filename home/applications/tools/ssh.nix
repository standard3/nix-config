{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
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
