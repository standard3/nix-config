{
  programs.alacritty = {
    enable = true;
    settings = {
      # General configuration
      live_config_reload = true;
      draw_bold_text_with_bright_colors = true;
      shell = "fish";

      # Environment variable
      env = {
        "TERM" = "xterm-256color";
      };

      # Window configuration
      window = {
        padding = {
          x = 10;
          y = 10;
        };

        # Spread additional padding evenly around the terminal content.
        dynamic_padding = true;

        # Window decorations
        decorations = "none";

        # Window class
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };

        # Resize increments
        # Prefer resizing window by discrete steps equal to cell dimensions.
        resize_increments = true;
      };

      # Fonts
      font = {
        # Normal (roman) font face
        normal = {
          family = "MesloLGM Nerd Font Mono";
          style = "Regular";
        };

        # Bold font face
        bold = {
          family = "MesloLGM Nerd Font Mono";
          style = "Bold";
        };

        # Italic font face
        italic = {
          family = "MesloLGM Nerd Font Mono";
          style = "Italic";
        };

        # Bold italic font face
        bold_italic = {
          family = "MesloLGM Nerd Font Mono";
          style = "Bold Italic";
        };

        # Point size
        size = 15;

        # Use built-in font for box drawing characters.
        # If `true`, Alacritty will use a custom built-in font for box drawing
        # characters (Unicode points 2500 - 259f).
        builtin_box_drawing = true;
      };

      # Text selection
      selection.semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";

      # Cursor
      cursor = {
        # Values for `shape`:
        #   - ▇ Block
        #   - _ Underline
        #   - | Beam
        style.shape = "Beam";

        # Values for `blinking`:
        #   - Never: Prevent the cursor from ever blinking
        #   - Off: Disable blinking by default
        #   - On: Enable blinking by default
        #   - Always: Force the cursor to always blink
        blinking = "On";

        blink_interval = 500; # Cursor blinking interval in milliseconds.

        # If this is `true`, the cursor will be rendered as a hollow box when the
        # window is not focused.
        unfocused_hollow = true;

        # Thickness of the cursor relative to the cell width as floating point number
        # from `0.0` to `1.0`.
        thickness = 0.25;
      };

      # Mouse cursor
      mouse.hide_when_typing = false;

      # Colors (theme gruvbox)
      # todo: nifixy with nix-colors
      colors = {
        primary = {
          # hard contrast: background = '#1d2021'
          background = "#282828";
          # soft contrast: background = '#32302f'
          foreground = "#ebdbb2";
        };

        normal = {
          black =   "#282828";
          red =     "#cc241d";
          green =   "#98971a";
          yellow =  "#d79921";
          blue =    "#458588";
          magenta = "#b16286";
          cyan =    "#689d6a";
          white =   "#a89984";
        };

        bright = {
          black =   "#928374";
          red =     "#fb4934";
          green =   "#b8bb26";
          yellow =  "#fabd2f";
          blue =    "#83a598";
          magenta = "#d3869b";
          cyan =    "#8ec07c";
          white =   "#ebdbb2";
        };
      };
    };
  };
}
