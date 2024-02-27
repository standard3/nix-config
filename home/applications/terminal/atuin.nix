{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      dialect = "uk";

      # Search mode
      search_mode_shell_up_key_binding = "fuzzy";
      filter_mode_shell_up_key_binding = "host";

      style = "compact";
      show_preview = true;
      show_help = false;

      exit_mode = "return-query";

      # Note that these regular expressions are unanchored, i.e. if they don't
      # start with ^ or end with $, they'll match anywhere in the command.
      history_filter = [ ];

      enter_accept = false;

      keymap_mode = "vim-insert";
    };
  };
}
