let
  language = "en_US.UTF-8";
  extraLanguage = "fr_FR.UTF-8";
  keyboardLayout = "fr";
in {
  # Select internationalisation properties
  i18n.defaultLocale = language;

  i18n.extraLocaleSettings = {
    LC_ADDRESS        = extraLanguage;
    LC_IDENTIFICATION = extraLanguage;
    LC_MEASUREMENT    = extraLanguage;
    LC_MONETARY       = extraLanguage;
    LC_NAME           = extraLanguage;
    LC_NUMERIC        = extraLanguage;
    LC_PAPER          = extraLanguage;
    LC_TELEPHONE      = extraLanguage;
    LC_TIME           = extraLanguage;
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
