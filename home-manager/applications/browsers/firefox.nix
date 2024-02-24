{ inputs, pkgs, ...}:

{
  # Options : https://mipmip.github.io/home-manager-option-search/?query=firefox
  programs.firefox = {
    enable = true;

    # List of policies : https://mozilla.github.io/policy-templates/
    policies = {
      Homepage = {
        StartPage = "previous-session";
      };

      ExtensionSettings = {
        "*".installation_mode = "blocked";
        blocked_install_message = "Imperative installation is banned !";

        # # uBlock Origin:
        # "uBlock0@raymondhill.net" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        #   installation_mode = "force_installed";
        # };

        # # ClearURLs
        # "{74145f27-f039-47ce-a470-a662b129930a}" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
        #   installation_mode = "force_installed";
        # };

        # # Privacy Badger
        # "jid1-MnnxcxisBPnSXQ@jetpack" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
        #   installation_mode = "force_installed";
        # };

        # # TOS; Didn't read
        # "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/terms-of-service-didnt-read/latest.xpi";
        #   installation_mode = "force_installed";
        # };

        # # Dashlane
        # "jetpack-extension@dashlane.com" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/dashlane/latest.xpi";
        #   installation_mode = "force_installed";
        # };

        # # Sponsorblock
        # "sponsorBlocker@ajay.app" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/dashlane/latest.xpi";
        #   installation_mode = "force_installed";
        # };
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";

        engines = {
          "Google".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "Amazon.fr".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };

      bookmarks = [
        {
          name = "";
          tags = [""];
          keyword = "";
          url = "";
        }
      ];

      # Search for extensions : https://nur.nix-community.org/repos/rycee/
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        clearurls
        privacy-badger
        # dashlane
        terms-of-service-didnt-read
        sponsorblock
      ];

      settings = {
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;
      };

      userChrome = ''

      '';

    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
