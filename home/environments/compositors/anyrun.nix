{ inputs, pkgs, ... }:

{
  imports = [ inputs.anyrun.homeManagerModules.default ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        shell
        stdin
        randr # to explore
      ];

      x = { fraction = 0.5; };
      y = { fraction = 0.5; };

      width  = { fraction = 0.25; };
      height = { fraction = 0.25; };

      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = null;
    };

    extraCss = ''
      /* Colors */
      @define-color col_main  #fabd2f;
      @define-color col_bg    #282828;
      @define-color col_bg_gr #2E3032;

      /* Animations */
      @keyframes glissement
      {
          from
          {
              margin-left: 5px;
          }

          to
          {
              margin-left: 0px;
          }
      }

      /* Properties */
      #window
      {
          background-color: transparent;
          font-family: 'Lexend', 'Bahnschrift', 'Inter';
      }

      box#main
      {
          background-color: @col_bg;
          color: @col_main;
          border-radius: 10px;
          margin: 1em;
          box-shadow: 0px 0px 8px 1px rgba(30, 30, 30, 0.5);
      }

      #main
      {
          border-radius: 10px;
          margin: 1em;
      }

      #entry
      {
          color: @col_main;
          background-image: -gtk-gradient(
              radial,
              center center, 0,
              center center, 1,
              from(@col_bg_gr), to(@col_bg)
          );

          border: 3px solid;
          border-color: @col_main;
          border-bottom-width: 3px;
          border-radius: 10px;

          font-weight: bold;
          box-shadow: none;
      }

      #plugin
      {
          color: @col_main;
          font-weight: bold;

          background-color: @col_bg;

          min-width: 1px;
      }

      label#plugin
      {
          border-bottom: 3px solid;

          padding: 4px;
          min-width: 2px;
      }

      #match
      {
          color: @col_main;
          background-color: @col_bg;
      }

      #match:selected, #match:hover
      {
          border: 2px groove @col_main;
          border-radius: 10px;
          font-size: 15px;
          padding: 7px;

          animation-duration: 0.1s;
          animation-name: glissement;
          animation-iteration-count: 1;
      }

      #match-desc
      {
          color: white;
          font-weight: normal;
      }
    '';

    # this file will be put in ~/.config/anyrun/some-plugin.ron
    # refer to docs of xdg.configFile for available options
    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: false,
        terminal: Some("alacritty"),
      )
    '';

    extraConfigFiles."shell.ron".text = ''
      Config(
        prefix: ":s",
      )
    '';
  };
}
