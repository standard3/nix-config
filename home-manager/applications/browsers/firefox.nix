{
  inputs
, lib
, config
, pkgs
, ...
}: {
  # imports = [
  #   inputs.nur.hmModules.nur
  # ];

  # Options : https://mipmip.github.io/home-manager-option-search/?query=firefox
  programs.firefox = {
    enable = true;

    # List of policies : https://mozilla.github.io/policy-templates/
    # policies = {
    #   ExtensionSettings = {
    #     "*".installation_mode = "blocked";
    #     "blocked_install_message" = "Imperative installation is banned !";
    #   };
    # };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";

        # todo: make a loop
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
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   dashlane
      #   privacy-badger
      #   ublock-origin
      # ];

      settings = {

      };

      userChrome = ''

      '';

    };
  };
}
