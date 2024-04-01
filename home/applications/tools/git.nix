{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # User and signature
    userName = "std3";
    userEmail = "67806187+standard3@users.noreply.github.com";

    iniContent.gpg = {
      format = "ssh";
      ssh = {
        allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      };
    };

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
      signByDefault = true;
    };

    ignores = [
      "*.direnv"
      "*.devenv"
      "*.envrc"
    ];

    delta.enable = true;

    aliases = {
      loc = "!f(){ git ls-files | ${pkgs.ripgrep}/bin/rg \"\\.\${1}\" | xargs wc -l; };f"; # lines of code
      br = "branch";
      ch = "checkout";
      chb = "checkout -b";
      st = "status";
      cm = "commit -m";
      ca = "commit -am";
      fuck = "commit --amend -m";
      dc = "diff --cached";
      graph = "log --all --decorate --graph";
      hist = "log --pretty=format:\"%Cgreen%h %Cblue[%cn] %Creset%cd %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all";
    };

    extraConfig = {
      color.ui = true;
      column.ui = "auto";

      core = {
        editor = "nvim";
        untrackedcache = true;
        fsmonitor = true;
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
      fetch.writeCommitGraph = true;
      branch.sort = "-committerdate";

      rerere.enabled = true;

      url = {
        "https://github.com/".insteadOf = "gh:";
        "ssh://git@github.com".pushInsteadOf = "gh:";
        "https://gitlab.com/".insteadOf = "gl:";
        "ssh://git@gitlab.com".pushInsteadOf = "gl:";
      };
    };

    # IncludeIf
    includes = [
      {
        path = "${config.home.homeDirectory}/2600/.gitconfig";
        condition = "gitdir:${config.home.homeDirectory}/2600/";
      }
    ];
  };
}
