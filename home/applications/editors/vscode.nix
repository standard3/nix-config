{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rnix-lsp # Nix language server
  ];

  programs.vscode = {
    enable = true;

    package = (pkgs.unstable.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.unstable.vscode-extensions; [
      # Languages
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      ms-python.python
      tamasfe.even-better-toml

      # Themes & icons
      jdinhlife.gruvbox
      pkief.material-icon-theme
      kamikillerto.vscode-colorize

      # Utilities
      github.copilot
      github.copilot-chat
    ];
    }).overrideAttrs (old: {
        inherit (pkgs.unstable.vscode) pname version;
    });

    # Disable mutable extensions
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    # Disable update checks
    enableUpdateCheck = false;

    userSettings = {
      # Window
      "window.zoomLevel" = 1;

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
}
