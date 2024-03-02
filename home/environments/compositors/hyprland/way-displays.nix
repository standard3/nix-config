{
  # home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
  #   templates = {
  #     scm-init = "git";
  #     params = {
  #       author-name = config.programs.git.userName;
  #       author-email = config.programs.git.userEmail;
  #       github-username = "malob";
  #     };
  #   };
  #   nix.enable = true;
  #   recommend-stack-upgrade = false;
  # };

  home.file.".config/way-displays/cfg.yaml".text = ''
    # Default cfg.yaml for way-displays.
    # Copy this to ~/.config/way-displays/cfg.yaml and edit it to your liking.
    #
    # See https://github.com/alex-courtis/way-displays/blob/master/doc/CONFIGURATION.md


    # Arrange displays in a ROW (default, left to right) or a COLUMN (top to bottom)
    ARRANGE: ROW

    # Align ROWs at the TOP (default), MIDDLE or BOTTOM
    # Align COLUMNs at the LEFT (default), MIDDLE or RIGHT
    ALIGN: TOP


    # The default ORDER is simply the order in which the displays are discovered.
    # Define your own.
    ORDER:
      #- 'DP-2'
      #- 'monitor description'
      #- 'HDMI-1'


    # Enable scaling, overrides AUTO_SCALE and SCALE
    SCALING: TRUE

    # The default is to scale each display by DPI.
    # This may be disabled and scale 1 will be used, unless a SCALE has been specified.
    AUTO_SCALE: TRUE

    # Set an allowed range for auto scale.
    AUTO_SCALE_MIN: 1.0
    #AUTO_SCALE_MAX: 2.0

    # Auto scale may be overridden for each display.
    SCALE:
      #- NAME_DESC: 'monitor description'
      #  SCALE: 1.75

    # Override the preferred mode.
    # WARNING: this may result in an unusable display. See https://github.com/alex-courtis/way-displays#known-issues-with-workarounds
    # for a possible workaround.
    MODE:
        # Resolution and refresh
        #- NAME_DESC: HDMI-A-1
        #  WIDTH: 1920
        #  HEIGHT: 1080
        #  HZ: 60

        # Resolution with highest refresh
        #- NAME_DESC: 'monitor description'
        #  WIDTH: 2560
        #  HEIGHT: 1440

        # Highest available
        #- NAME_DESC: DP-2
        #  MAX: TRUE

    # Rotate or translate the display.
    # 90, 180, 270, FLIPPED, FLIPPED-90, FLIPPED-180, FLIPPED-270
    TRANSFORM:
      # - NAME_DESC: 'monitor description'
      #   TRANSFORM: 270

    # VRR / adaptive sync is enabled by default. Disable it per display.
    VRR_OFF:
      # - DP-2
      # - '!.*my monitor.*'


    # Laptop displays usually start with eDP e.g. eDP-1. This may be overridden if
    # your laptop is different.
    #LAPTOP_DISPLAY_PREFIX: 'eDP'


    # One of: ERROR, WARNING, INFO (default), DEBUG
    LOG_THRESHOLD: INFO


    # Disable the specified displays.
    DISABLED:
      #- "eDP-1"
  '';
}
