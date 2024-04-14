{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package = (pkgs.unstable.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.unstable.vscode-extensions; [
        # Languages
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        redhat.vscode-yaml
        yzhang.markdown-all-in-one
        ms-python.black-formatter
        ms-python.isort
        # ms-python.pylint
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cpptools-extension-pack
        # maziac.asm-code-lens
        ms-vscode.makefile-tools

        # Themes & icons
        jdinhlife.gruvbox
        pkief.material-icon-theme
        kamikillerto.vscode-colorize

        # Utilities
        github.copilot
        github.copilot-chat
        github.vscode-github-actions
        arrterian.nix-env-selector
        vscodevim.vim
        vadimcn.vscode-lldb # debugging
        christian-kohler.path-intellisense
        oderwat.indent-rainbow
        usernamehw.errorlens
        tomoki1207.pdf
        ms-vsliveshare.vsliveshare
      ];
    }).overrideAttrs (old: {
      inherit (pkgs.unstable.vscode) pname version;
    });

    # Enable mutable extensions, allows to temporilary disable extensions from the UI
    mutableExtensionsDir = true;
    enableExtensionUpdateCheck = false;

    # Disable update checks
    enableUpdateCheck = false;

    userSettings = {
      # Window
      "window.zoomLevel" = 1;
      "window.dialogStyle" = "native";
      "window.menuBarVisibility" = "toggle";

      # Workbench
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.commandPalette.preserveInput" = true;

      # Integrated terminal
      "terminal.integrated.fontFamily" = "MesloLGM Nerd Font";
      # "terminal.integrated.defaultProfile.linux" = "fish";

      # Editor
      "editor.bracketPairColorization.enabled" = true;
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "editor.fontFamily" = "MesloLGM Nerd Font";
      "editor.fontLigatures" = true;
      "editor.suggest.insertMode" = "replace";
      "editor.lineHeight" = 20;
      "editor.lineNumbers" = "relative";
      "editor.linkedEditing" = true;
      "editor.inlayHints.enabled" = true;
      "editor.inlineSuggest.enabled" = true;
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
      "editor.formatOnSave" = true;
      "editor.minimap.autohide" = true;
      "editor.minimap.maxColumn" = 100;
      "editor.quickSuggestions" = {
        "comments" = "on";
      };
      "editor.semanticTokenColorCustomizations" = {
        "rules" = {
          "*.mutable" = {
            "fontStyle" = "underline"; # set to empty string to disable underline, which is the default
          };
        };
      };

      # Files
      "files.trimTrailingWhitespace" = true;
      "files.autoGuessEncoding" = true;
      "files.defaultLanguage" = "markdown";
      "files.hotExit" = "onExitAndWindowClose";
      "files.insertFinalNewline" = true;
      "files.simpleDialog.enable" = true;

      # Debug
      "debug.allowBreakpointsEverywhere" = true;

      # Default formatters
      "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
      "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
      "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";

      # Extensions
      # Nix
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      "nix.serverPath" = "rnix-lsp";
      "nix.serverSettings"."nil"."formatting"."command" = [ "${pkgs.alejandra}/bin/alejandra" ];

      # Rust, see https://rust-analyzer.github.io/manual.html#vs-code-2
      "rust-analyser.checkOnSave.command" = "clippy";
      "rust-analyser.rustfmt.overrideCommand" = [ "rustfmt" ];

      # Python
      "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
      "python.languageServer" = "Pylance";
      "python.analysis.typeCheckingMode" = "strict";
      "python.analysis.autoFormatStrings" = true;

      # Path Intellisense
      "path-intellisense.autoSlashAfterDirectory" = true;
      "path-intellisense.autoTriggerNextSuggestion" = true;
      "path-intellisense.extensionOnImport" = true;
      "path-intellisense.showHiddenFiles" = true;

      # Git
      "git.autofetch" = true;
      # "git.enableCommitSigning" = true;
      "git.enableSmartCommit" = true;
    };
  };
}
