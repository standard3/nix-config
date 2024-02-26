{ inputs, pkgs, ... }:

let
  zjstatus = inputs.zjstatus.packages.${pkgs.system}.default;
in {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.configFile."zellij/config.kdl".text = ''
    /////////////////////
    // UI & Theme
    /////////////////////
    theme "gruvbox-dark"

    ui {
        pane_frames {
            rounded_corners true
            hide_session_name true
        }
    }

    /////////////////////
    // Options
    /////////////////////
    on_force_close                "quit"
    pane_frames                   true
    session_serialization         true
    pane_viewport_serialization   true
    default_shell                 "fish"
    mouse_mode                    true
    copy_on_select                false
    scrollback_editor             "/usr/bin/vim"
    styled_underlines             true

    // Layouts
    // layout_dir     "/home/th.abel/.config/zellij/layouts"
    default_layout "custom"

    /////////////////////
    // Plugins
    /////////////////////
    plugins {
        tab-bar         { path "tab-bar"; }
        status-bar      { path "status-bar"; }
        strider         { path "strider"; }
        compact-bar     { path "compact-bar"; }
        session-manager { path "session-manager"; }
    }

    /////////////////////
    // Keybinds
    /////////////////////
    // If you'd like to override the default keybindings completely, be sure to change "keybinds" to "keybinds clear-defaults=true"
    keybinds {
        normal {
            bind "Alt c" { Copy; }  // using copy_on_select=false
            bind "Alt l" { Clear; } // clear scrollback buffer
        }

        locked {
            bind "Ctrl g" { SwitchToMode "Normal"; }
        }

        resize {
            bind "Ctrl n"    { SwitchToMode "Normal"; }
            bind "h" "Left"  { Resize "Increase Left"; }
            bind "j" "Down"  { Resize "Increase Down"; }
            bind "k" "Up"    { Resize "Increase Up"; }
            bind "l" "Right" { Resize "Increase Right"; }
            bind "H"         { Resize "Decrease Left"; }
            bind "J"         { Resize "Decrease Down"; }
            bind "K"         { Resize "Decrease Up"; }
            bind "L"         { Resize "Decrease Right"; }
            bind "=" "+"     { Resize "Increase"; }
            bind "-"         { Resize "Decrease"; }
        }

        pane {
            bind "Ctrl p"    { SwitchToMode "Normal"; }
            bind "h" "Left"  { MoveFocus "Left"; }
            bind "l" "Right" { MoveFocus "Right"; }
            bind "j" "Down"  { MoveFocus "Down"; }
            bind "k" "Up"    { MoveFocus "Up"; }

            bind "p" { SwitchFocus; }
            bind "n" { NewPane; SwitchToMode "Normal"; }
            bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
            bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
            bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
            bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
        }

        move {
            bind "Ctrl h"    { SwitchToMode "Normal"; }
            bind "n" "Tab"   { MovePane; }
            bind "p"         { MovePaneBackwards; }
            bind "h" "Left"  { MovePane "Left"; }
            bind "j" "Down"  { MovePane "Down"; }
            bind "k" "Up"    { MovePane "Up"; }
            bind "l" "Right" { MovePane "Right"; }
        }

        tab {
            bind "Ctrl t" { SwitchToMode "Normal"; }
            bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
            bind "h" "Left" "Up" "k" { GoToPreviousTab; }
            bind "l" "Right" "Down" "j" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "Normal"; }
            bind "x" { CloseTab; SwitchToMode "Normal"; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
            bind "b" { BreakPane; SwitchToMode "Normal"; }
            bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
            bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
            bind "1" { GoToTab 1; SwitchToMode "Normal"; }
            bind "2" { GoToTab 2; SwitchToMode "Normal"; }
            bind "3" { GoToTab 3; SwitchToMode "Normal"; }
            bind "4" { GoToTab 4; SwitchToMode "Normal"; }
            bind "5" { GoToTab 5; SwitchToMode "Normal"; }
            bind "6" { GoToTab 6; SwitchToMode "Normal"; }
            bind "7" { GoToTab 7; SwitchToMode "Normal"; }
            bind "8" { GoToTab 8; SwitchToMode "Normal"; }
            bind "9" { GoToTab 9; SwitchToMode "Normal"; }
            bind "Tab" { ToggleTab; }
        }

        scroll {
            bind "Ctrl s" { SwitchToMode "Normal"; }
            bind "e" { EditScrollback; SwitchToMode "Normal"; }
            bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            // uncomment this and adjust key if using copy_on_select=false
            // bind "Alt c" { Copy; }
        }

        search {
            bind "Ctrl s" { SwitchToMode "Normal"; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            bind "n" { Search "down"; }
            bind "p" { Search "up"; }
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "w" { SearchToggleOption "Wrap"; }
            bind "o" { SearchToggleOption "WholeWord"; }
        }

        entersearch {
            bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
            bind "Enter" { SwitchToMode "Search"; }
        }

        renametab {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
        }

        renamepane {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
        }

        session {
            bind "Ctrl o" { SwitchToMode "Normal"; }
            bind "Ctrl s" { SwitchToMode "Scroll"; }
            bind "d" { Detach; }
            bind "w" {
                LaunchOrFocusPlugin "zellij:session-manager" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Normal"
            }
        }

        tmux {
            bind "Ctrl ²" { SwitchToMode "Scroll"; }
            bind "Ctrl b" { Write 2; SwitchToMode "Normal"; }
            bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
            bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
            bind "c" { NewTab; SwitchToMode "Normal"; }
            bind "," { SwitchToMode "RenameTab"; }
            bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
            bind "n" { GoToNextTab; SwitchToMode "Normal"; }
            bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
            bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
            bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
            bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
            bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
            bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
            bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
            bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
            bind "o" { FocusNextPane; }
            bind "d" { Detach; }
            bind "Space" { NextSwapLayout; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
        }

        shared_except "locked" {
            bind "Ctrl g" { SwitchToMode "Locked"; }
            bind "Ctrl q" { Quit; }
            bind "Alt n" { NewPane; }
            bind "Alt t" { NewTab; }
            bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
            bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
            bind "Alt j" "Alt Down" { MoveFocus "Down"; }
            bind "Alt k" "Alt Up" { MoveFocus "Up"; }
            bind "Alt =" "Alt +" { Resize "Increase"; }
            bind "Alt -" { Resize "Decrease"; }
            bind "Alt [" { PreviousSwapLayout; }
            bind "Alt ]" { NextSwapLayout; }

            // Plugins
            bind "Alt m" {
                LaunchPlugin "file:~/.config/zellij/plugins/monocle.wasm" {
                    in_place true;
                    kiosk    true;
                };
                SwitchToMode "Normal";
            }
        }

        shared_except "normal" "locked" {
            bind "Enter" "Esc" { SwitchToMode "Normal"; }
        }

        shared_except "pane" "locked" {
            bind "Ctrl p" { SwitchToMode "Pane"; }
        }

        shared_except "resize" "locked" {
            bind "Ctrl n" { SwitchToMode "Resize"; }
        }

        shared_except "scroll" "locked" {
            bind "Ctrl s" { SwitchToMode "Scroll"; }
        }

        shared_except "session" "locked" {
            bind "Ctrl o" { SwitchToMode "Session"; }
        }

        shared_except "tab" "locked" {
            bind "Ctrl t" { SwitchToMode "Tab"; }
        }

        shared_except "move" "locked" {
            bind "Ctrl h" { SwitchToMode "Move"; }
        }

        shared_except "tmux" "locked" {
            bind "Ctrl b" { SwitchToMode "Tmux"; }
        }
    }
  '';

  xdg.configFile."zellij/layouts/custom.kdl".text = ''
    layout {
        pane split_direction="vertical" {
            pane
        }

        pane size=1 borderless=true {
            plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
                format_left  "{mode}#[fg=#a89984,bg=#363231] #[fg=#363231,bg=#a89984,italic]{tabs}#[fg=#a89984,bg=#363231]"
                format_right "#[fg=#d5c4a1,bg=#363231]{datetime}#[fg=#a89984,bg=#d5c4a1] #[fg=#363231,bg=#a89984] {session} #[fg=#a89984,bg=#363231]▒░"
                format_space "#[bg=#363231]"

                border_enabled  "true"
                border_char     "─"
                border_format   "#[fg=#b8bb26]{char}"
                border_position "top"

                hide_frame_for_single_pane "true"

                mode_normal        "#[fg=#b8bb26,bg=#363231] #[fg=#363231,bg=#b8bb26]  {name} #[fg=#b8bb26,bg=#363231] "
                mode_locked        "#[fg=#fb4934,bg=#363231] #[fg=#363231,bg=#fb4934]  {name} #[fg=#fb4934,bg=#363231] "
                mode_resize        "#[fg=#d79921,bg=#363231] #[fg=#363231,bg=#d79921]  {name} #[fg=#d79921,bg=#363231] "
                mode_pane          "#[fg=white,bg=#363231] #[fg=#363231,bg=white] 󰓫 {name} #[fg=white,bg=#363231] "
                mode_tab           "#[fg=#fabd2f,bg=#363231] #[fg=#363231,bg=#fabd2f] 󰓩 {name} #[fg=#fabd2f,bg=#363231] "
                mode_scroll        "#[fg=#83a59a,bg=#363231] #[fg=#363231,bg=#83a59a]  {name} #[fg=#83a59a,bg=#363231] "
                mode_enter_search  "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_search        "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_rename_tab    "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_rename_pane   "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_session       "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_move          "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_prompt        "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_tmux          "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "

                tab_normal   "#[fg=#363231,bg=#a89984,italic] {name} "
                tab_active   "#[fg=#ebdbb2,bg=#a89984,bold]#[fg=#363231,bg=#ebdbb2,bold]{index}  {name}#[fg=#ebdbb2,bg=#a89984,bold]"

                command_git_branch_command   "git rev-parse --abbrev-ref HEAD"
                command_git_branch_format    "#[fg=blue] {stdout} "
                command_git_branch_interval  "10"

                datetime        "#[fg=#363231,bg=#d5c4a1]󰃭 {format}"
                datetime_format "%d/%m/%Y"
                datetime_timezone "Europe/Paris"
            }
        }
    }
  '';
}
