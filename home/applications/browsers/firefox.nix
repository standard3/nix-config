{ inputs, lib, pkgs, config, ... }:

let
  firefox-cascade = pkgs.fetchFromGitHub {
    owner = "andreasgrafen";
    repo = "cascade";
    rev = "2f70e8619ce5c721fe9c0736b25c5a79938f1215";
    sha256 = "1gf65iypcc8lzp2s5mwbf71n77c9ldr0g9ic2p9w13hdax1q3qqw";
    name = "firefox-cascade";
  };
in
{
  imports = [
    inputs.arkenfox.hmModules.default
  ];

  # Options : https://mipmip.github.io/home-manager-option-search/?query=firefox
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;

    arkenfox = {
      enable = true;
      # version = pkgs.firefox.version;
    };

    # List of policies : https://mozilla.github.io/policy-templates/
    # or https://github.com/mozilla/policy-templates/blob/master/linux/policies.json
    policies = {
      Homepage = {
        StartPage = "previous-session";
        AppAutoUpdate = false;
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableForgetButton = true;
        DisableFormHistory = true;
        DisablePasswordReveal = true;
        DisableMasterPasswordCreation = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSafeMode = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        FirefoxHome = {
          Highlights = false;
          Pocket = false;
          Snippets = false;
          SponsporedPocket = false;
          SponsporedTopSites = false;
        };
        NoDefaultBookmarks = true;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        SanitizeOnShutdown = {
          FormData = true;
        };
        UseSystemPrintDialog = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisplayBookmarksToolbar = "always";
      };

      # ExtensionSettings = {
      #   "*".installation_mode = "blocked";
      #   blocked_install_message = "Imperative installation is banned !";
      # };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # See https://github.com/dwarfmaster/arkenfox-nixos for options
      arkenfox = {
        "0000".enable = true;
        "0100" = {
          enable = true;
        };
        "0200" = {
          enable = true;
        };
        "0300".enable = true;
        # We keep safebrowsing
        "0400".enable = false;
        "0600" = {
          enable = true;
          "0610"."browser.send_pings".enable = true;
        };
        "0700" = {
          enable = true;
        };
        "0800" = {
          enable = true;
          "0810"."browser.formfill.enable".value = true;
        };
        "0900".enable = true;
        "1000" = {
          enable = true;
          # Enable disk cache for performance reasons
          "1001"."browser.cache.disk.enable".enable = true;
          "1001"."browser.cache.disk.enable".value = true;
        };
        "1200".enable = true;
        "1700".enable = true;
        "2600" = {
          enable = true;
          # The recent documents feature is useful
          "2653".enable = false;
        };
        "2700".enable = true;
      };

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
          tags = [ "" ];
          keyword = "";
          url = "";
        }
      ];

      # Search for extensions : https://nur.nix-community.org/repos/rycee/
      # If these extensions are disabled, try searching in {firefoxprofile}/extension-settings.json
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        # Privacy
        clearurls
        privacy-badger
        # terms-of-service-didnt-read

        # Utilities
        ublock-origin
        sponsorblock
        istilldontcareaboutcookies
        # dashlane # can't figure out how to install it

        # Styling
        gruvbox-dark-theme
      ];

      settings = {
        # General preferences
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "browser.ctrlTab.recentlyUsedOrder" = true;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # Security & privacy
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.webrtc.legacyGlobalIndicator" = false;
        "signon.rememberSignons" = false;

        # Theming
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "gfx.webrender.all" = true;
        # "layers.acceleration.force-enabled" = true;
        # "svg.context-properties.content.enabled" = true;
      };

      # userChrome = ''
      #   /* Cascade */
      #   @import '${firefox-cascade}/chrome/includes/cascade-config-mouse.css';
      #   @import '${firefox-cascade}/chrome/includes/cascade-layout.css';
      #   @import '${firefox-cascade}/chrome/includes/cascade-floating-panel.css';
      #   @import '${firefox-cascade}/chrome/includes/cascade-nav-bar.css';
      #   @import '${firefox-cascade}/chrome/includes/cascade-tabs.css';
      #   @import '${firefox-cascade}/chrome/includes/cascade-colours.css';

      #   @import '${firefox-cascade}/integrations/tabcenter-reborn/cascade-tcr.css';

      #   @media (prefers-color-scheme: dark) { :root {
      #     /* These colours are (mainly) used by the
      #       Container Tabs Plugin */
      #     --uc-identity-colour-blue:      #458588;
      #     --uc-identity-colour-turquoise: #689d6a;
      #     --uc-identity-colour-green:     #98971a;
      #     --uc-identity-colour-yellow:    #d79921;
      #     --uc-identity-colour-orange:    #D65d0e;
      #     --uc-identity-colour-red:       #fb4934;
      #     --uc-identity-colour-pink:      #b16286;
      #     --uc-identity-colour-purple:    #786FA6;

      #     /*  Cascades main Colour Scheme */
      #     --uc-base-colour:               #282828;
      #     --uc-highlight-colour:          #3c3836;
      #     --uc-inverted-colour:           #ebdbb2;
      #     --uc-muted-colour:              var(--uc-identity-colour-yellow);
      #     --uc-accent-colour:             var(--uc-identity-colour-green);
      #   }}

      #   @media (prefers-color-scheme: light) { :root {
      #     /* These colours are (mainly) used by the
      #       Container Tabs Plugin */
      #     --uc-identity-colour-blue:      #1D65F5;
      #     --uc-identity-colour-turquoise: #209FB5;
      #     --uc-identity-colour-green:     #40A02B;
      #     --uc-identity-colour-yellow:    #E49320;
      #     --uc-identity-colour-orange:    #FE640B;
      #     --uc-identity-colour-red:       #FC5C65;
      #     --uc-identity-colour-pink:      #EC83D0;
      #     --uc-identity-colour-purple:    #822FEE;

      #     /*  Cascades main Colour Scheme */
      #     --uc-base-colour:               #FAFAFC;
      #     --uc-highlight-colour:          #DADADC;
      #     --uc-inverted-colour:           #1E2021;
      #     --uc-muted-colour:              #191B1C;
      #     --uc-accent-colour:             var(--uc-identity-colour-purple);
      #   }}

      #   /* General edits */

      #   :root {
      #     --uc-urlbar-min-width: 30vw;
      #     --uc-urlbar-max-width: 45vw;
      #   }

      #   #tracking-protection-icon-container {
      #     display: none !important;
      #   }

      #   #context-savepage, #context-sep-selectall, #context-take-screenshot, #context-sep-screenshots {
      #     display: none !important;
      #   }

      #   #context-openlinkprivate, #context-sendimage, #context-sep-setbackground, #context-setDesktopBackground, #context-searchselect, #context-searchselect-private, #context-sep-sendlinktodevice {
      #     display: none !important;
      #   }

      #   @media (min-width: 0px) {
      #     #navigator-toolbox { display: flex; flex-wrap: wrap; flex-direction: row; }

      #     #nav-bar {
      #       order: var(--uc-urlbar-position);
      #       width: var(--uc-urlbar-min-width);
      #     }

      #     #nav-bar #urlbar-container { min-width: 40px !important; width: auto !important; }

      #     #titlebar {
      #       order: 2;
      #       width: calc(100vw - var(--uc-urlbar-min-width) - 1px);
      #     }

      #     #PersonalToolbar {
      #       order: var(--uc-toolbar-position);
      #       width: 100%;
      #     }

      #     #navigator-toolbox:focus-within #nav-bar { width: var(--uc-urlbar-max-width); }
      #     #navigator-toolbox:focus-within #titlebar { width: calc(100vw - var(--uc-urlbar-max-width) - 1px); }

      #   }
      # '';

      userContent = ''

      '';
    };
  };

  xdg.mimeApps.defaultApplications = lib.genAttrs [
    "text/html"
    "text/xml"
    "application/xml"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/about"
  ]
    (_: "firefox.desktop");
}
