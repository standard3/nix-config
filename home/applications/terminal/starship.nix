{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;

    settings = {
      format = lib.concatStrings [
        "[░▒](#504945)"
        "[󱡓](bg:#504945 fg:#504945)"
        "$directory"
        "[](fg:#978A78 bg:#48423E)"
        "$git_branch"
        "$git_status"
        "[](fg:#48423E bg:#b8bb26)"
        "$c"
        "$python"
        "$nim"
        "$rust"
        "[](fg:#b8bb26 bg:#fabd2f)"
        "$time"
        "[](fg:#fabd2f)"
        "\n"
        "$cmd_duration"
        "$character"
      ];

      # General configuration
      add_newline = false;
      line_break.disabled = true;

      # General modules
      username = {
        show_always = true;
        style_user = "bg:#ebdbb2";
        style_root = "bg:#9A348E";
        format = "[ $user ]($style)";
        disabled = false;
      };

      directory = {
        style = "fg:#363231 bg:#978A78";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = " /";

        substitutions = {
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:#48423E";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#48423E";
        format = "[$all_status$ahead_behind ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "fg:#363231 bg:#fabd2f";
        format = "[  $time ]($style)";
      };

      character = {
        success_symbol = "[ ➜](#fbf1c7)";
        error_symbol = "[ ➜](#cc241d)";
      };

      cmd_duration = {
        min_time = 500;
        format = " [$duration](#fbf1c7)";
      };

      # Languages modules
      c = {
        symbol = " ";
        style = "fg:#535411 bg:#b8bb26";
        format = "[ $symbol ($version) ]($style)";
      };

      python = {
        symbol = " ";
        style = "fg:#535411 bg:#b8bb26";
        format = "[ $symbol ($version) ]($style)";
      };

      nim = {
        symbol = " ";
        style = "fg:#535411 bg:#b8bb26";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = " ";
        style = "fg:#535411 bg:#b8bb26";
        format = "[ $symbol ($version) ]($style)";
      };
    };
  };
}
