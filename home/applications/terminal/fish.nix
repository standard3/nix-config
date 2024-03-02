{ lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      fish_ssh_agent
      list_dir
    '';

    loginShellInit = ''
      # Colors
      set -l teal 94e2d5
      set -l flamingo f2cdcd
      set -l mauve cba6f7
      set -l pink f5c2e7
      set -l red f38ba8
      set -l peach fab387
      set -l green a6e3a1
      set -l yellow f9e2af
      set -l blue 89b4fa
      set -l gray 1f1d2e
      set -l black 191724

      # colored-man => https://github.com/decors/fish-colored-man
      set -g man_blink -o $teal
      set -g man_bold -o $yellow
      set -g man_standout -b $gray
      set -g man_underline -u $blue
    '';

    plugins = [
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages;
      }
      {
        name = "async-prompt";
        src = pkgs.fishPlugins.async-prompt;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer;
      }
      {
        name = "nix-completions";
        src = pkgs.fetchFromGitHub {
          owner = "kidonng";
          repo = "nix-completions.fish";
          rev = "cd8a43bed96e0acc02228bc77502be8ba5fa0548";
          sha256 = "sha256-spnLmde41qQt8uJZFwiH0igFuVqZ6SvkwdA9Kbe2yz8=";
        };
      }
    ];

    functions = {
      cheat = {
        description = "Alias for cheat.sh";
        body = ''
          curl "cheat.sh/$argv?style=native"
        '';
      };

      list_dir = {
          body = "if status --is-interactive; echo ''; ls; end;";
          onVariable = "PWD";
      };

      # wrapper for non-posix ssh-agent
      add-ssh = {
        description = "Start ssh-agent if not started yet, or uses already started ssh-agent.";
        body = ''
          fish_ssh_agent
          ssh-add -q -t 10h
        '';
      };

      __ssh_agent_is_started = {
        description = "check if ssh agent is already started";
        body = ''
          if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
            source $SSH_ENV > /dev/null
          end

          if test -z "$SSH_AGENT_PID"
            return 1
          end

          ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
          return $status
        '';
      };

      __ssh_agent_start = {
        description = "start a new ssh agent";
        body = ''
          ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
          chmod 600 $SSH_ENV
          source $SSH_ENV > /dev/null
          true  # suppress errors from setenv, i.e. set -gx
        '';
      };

      fish_ssh_agent = {
        description = "Start ssh-agent if not started yet, or uses already started ssh-agent.";
        body = ''
          if test -z "$SSH_ENV"
            set -xg SSH_ENV $HOME/.ssh/environment
          end

          if not __ssh_agent_is_started
            __ssh_agent_start
          end
        '';
      };
    };

    shellAbbrs = {
      # Git
      gco = "git checkout";
      gs  = "git status";
      gb  = "git branch";
      ga  = "git add";
      gaa = "git add .";
      # "gcm" = {
      #   expansion = "git commit -m '%'";
      #   setCursor = true;
      # };
      gpl = "git pull";
      gpu = "git push";

      # Nix
      ngc = "nix-collect-garbage";
    };

    shellAliases = {
      # Navigating files and directories
      la = "eza -1 --icons --group-directories-first --grid --long --no-time --group --all";
      ls = "eza -1 --icons --group-directories-first";
      l  = "eza --git --icons --group-directories-first --long --group --all";

      c    = "bat";
      cat  = "bat";
      catp = "bat --plain";

      cd = "z";

      # Utilities
      cl = "clear";
      ip = "ip -c";
      h  = "history";
      hgrep = "history | rg $1";
      mkdir = "mkdir -p";
      wget  = "wget -c";

      # System
      meminfo = "free -hlt --mega";
      mostu   = "du -hsx * | sort -rh | head -10";
      top     = "btop";
      ciao    = "shutdown now";

      # Editors
      vi  = "nvim";
      vim = "nvim";

      # Hyprland
      hyprland-debug = "watch -n 0.1 'bat /tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/hyprland.log | grep -v \"arranged\" | tail -n 40'";

      # Nix
      rebuild = "sudo nixos-rebuild switch --flake ~/dev/nix-config/#jupiter";
    };
  };
}
