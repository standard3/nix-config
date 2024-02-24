let
  language       = "en_US.UTF-8";
  extraLanguage  = "fr_FR.UTF-8";
  keyboardLayout = "fr";
in {
  # Select internationalisation properties
  i18n.defaultLocale = language;

  i18n.extraLocaleSettings = {
    LC_ADDRESS        = defaultLanguage;
    LC_IDENTIFICATION = defaultLanguage;
    LC_MEASUREMENT    = defaultLanguage;
    LC_MONETARY       = defaultLanguage;
    LC_NAME           = defaultLanguage;
    LC_NUMERIC        = defaultLanguage;
    LC_PAPER          = defaultLanguage;
    LC_TELEPHONE      = defaultLanguage;
    LC_TIME           = defaultLanguage;
  };

  # Configure timezone automatically
  services.automatic-timezoned.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = keyboardLayout;
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = keyboardLayout;
}
