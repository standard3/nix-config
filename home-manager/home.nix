{
  inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./environments
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "abel";
    homeDirectory = "/home/abel";
  };

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;

  programs.vscode = {
    enable = true;

    # Allow mutable extensions
    enableExtensionUpdateCheck = true;
    mutableExtensionsDir = true;

    # Disable update checks
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      # Languages
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      ms-python.python

      # Themes & icons
      jdinhlife.gruvbox
      pkief.material-icon-theme

      # Utilities
      # github.copilot
      # github.copilot-chat
    ];

    userSettings = {
      # Workbench
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.commandPalette.preserveInput" = true;

      # Integrated terminal
      "terminal.integrated.fontFamily" = "MesloLGM Nerd Font";
      # "terminal.integrated.defaultProfile.linux" = "fish";

      # Editor
      "editor.fontFamily" = "MesloLGM Nerd Font";
      "editor.suggest.insertMode" = "replace";
      "editor.lineHeight" = 20;
      "editor.lineNumbers" = "relative";
      "editor.linkedEditing" = true;
      "editor.mouseWheelZoom" = true;
      "editor.padding.top" = 10;
      "editor.parameterHints.cycle" = true;
      "editor.renderLineHighlight" = "all";
      "editor.renderWhitespace" = "trailing";
      "editor.roundedSelection" = false;
      "editor.scrollbar.verticalScrollbarSize" = 20;
      "editor.semanticHighlighting.enabled" = true;
      "editor.showFoldingControls" = "always";
      "editor.stickyScroll.enabled" = true;
      "editor.tabCompletion" = "on";
      "editor.unicodeHighlight.includeComments" = true;
      "editor.cursorSurroundingLines" = 5;
      "editor.formatOnPaste" = true;
      "editor.minimap.autohide" = true;
      "editor.minimap.maxColumn" = 100;
      "editor.quickSuggestions" = {
          "comments" = "on";
      };

      # Files
      "files.trimTrailingWhitespace" = true;
      "files.autoGuessEncoding" = true;
      "files.defaultLanguage" = "markdown";
      "files.hotExit" = "onExitAndWindowClose";
      "files.insertFinalNewline" = true;
      "files.simpleDialog.enable" = true;

      # Extensions
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "rnix-lsp";
    };
  };

  home.packages = with pkgs; [
    firefox

    # related to editor
    rnix-lsp
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    userName  = "std3";
    userEmail = "67806187+standard3@users.noreply.github.com";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
