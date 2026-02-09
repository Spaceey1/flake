{
  lib,
  pkgs,
  config,
  ...
}:

let
  bindsKdl = ''
    gestures {
    	hot-corners {
    		off
    	}
    }
    binds  {
    	Mod+Shift+Slash { show-hotkey-overlay; }

    	Ctrl+Tab { spawn "${pkgs.wayvr}/bin/wayvrctl" "show-hide"; }
    	Mod+Return hotkey-overlay-title="Open a Terminal" { spawn "${pkgs.kitty}/bin/kitty"; }
    	Mod+I { spawn "${pkgs.nemo-with-extensions}/bin/nemo"; }
    	Mod+E { spawn "${pkgs.librewolf}/bin/librewolf"; }
    	Mod+P hotkey-overlay-title="Open rofi" { spawn "${config.programs.rofi.finalPackage}/bin/rofi" "-show" "combi" "-combi-modi" "window,drun" "-no-history" "-drun-match-fields" "name" "-no-tokenize"; }

    	Super+Ctrl+Shift+BracketLeft hotkey-overlay-title="Lock the Screen" { spawn "${pkgs.hyprlock}/bin/hyprlock"; }

    	XF86AudioRaiseVolume allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
    	XF86AudioLowerVolume allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
    	XF86AudioMute        allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    	XF86AudioMicMute     allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

    	XF86AudioPlay { spawn "${pkgs.playerctl}/bin/playerctl" "play-pause"; }
    	XF86AudioNext { spawn "${pkgs.playerctl}/bin/playerctl" "next"; }
    	XF86AudioPrev { spawn "${pkgs.playerctl}/bin/playerctl" "previous"; }
    	XF86AudioStop { spawn "${pkgs.playerctl}/bin/playerctl" "stop"; }

    	XF86MonBrightnessUp { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "+10%"; }
    	XF86MonBrightnessDown { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "10%-"; }

    	Mod+Escape { spawn "${pkgs.dunst}/bin/dunstctl" "close-all"; }
    	Mod+BracketLeft { spawn "${config.programs.rofi.finalPackage}/bin/rofi" "-show" "emoji" "-emoji-mode" "insert_no_copy"; }

    	Mod+Tab { toggle-overview; }
    	Mod+Shift+Q { close-window; }
    	Mod+Shift+Ctrl+Q { spawn "${./killfocused.sh}"; }
    	Mod+H     { focus-column-left; }
    	Mod+L     { focus-column-right; }

    	Mod+Shift+H     { move-column-left; }
    	Mod+Shift+L     { move-column-right; }

    	Mod+J     { focus-window-or-workspace-down; }
    	Mod+K     { focus-window-or-workspace-up; }
    	Mod+Shift+J     { move-window-down-or-to-workspace-down; }
    	Mod+Shift+K     { move-window-up-or-to-workspace-up; }

    	Mod+Home { focus-column-first; }
    	Mod+End  { focus-column-last; }
    	Mod+Ctrl+Home { move-column-to-first; }
    	Mod+Ctrl+End  { move-column-to-last; }

    	Alt+H     { focus-monitor-left; }
    	Alt+L     { focus-monitor-right; }

    	Alt+Shift+H { move-column-to-monitor-left; }
    	Alt+Shift+L { move-column-to-monitor-right; }

    	Mod+Page_Down      { focus-workspace-down; }
    	Mod+Page_Up        { focus-workspace-up; }
    	Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
    	Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
    	Mod+Ctrl+U         { move-column-to-workspace-down; }
    	Mod+Ctrl+I         { move-column-to-workspace-up; }

    	// You can bind mouse wheel scroll ticks using the following syntax.
    	// These binds will change direction based on the natural-scroll setting.
    	//
    	// To avoid scrolling through workspaces really fast, you can use
    	// the cooldown-ms property. The bind will be rate-limited to this value.
    	// You can set a cooldown on any bind, but it's most useful for the wheel.
    	Mod+Shift+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
    	Mod+Shift+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
    	Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
    	Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

    	Mod+Shift+WheelScrollRight      { focus-column-right; }
    	Mod+Shift+WheelScrollLeft       { focus-column-left; }
    	Mod+Ctrl+WheelScrollRight { move-column-right; }
    	Mod+Ctrl+WheelScrollLeft  { move-column-left; }

    	// Usually scrolling up and down with Shift in applications results in
    	// horizontal scrolling; these binds replicate that.
    	Mod+WheelScrollDown      { focus-column-right; }
    	Mod+WheelScrollUp        { focus-column-left; }
    	Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
    	Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

    	// Similarly, you can bind touchpad scroll "ticks".
    	// Touchpad scrolling is continuous, so for these binds it is split into
    	// discrete intervals.
    	// These binds are also affected by touchpad's natural-scroll, so these
    	// example binds are "inverted", since we have natural-scroll enabled for
    	// touchpads by default.
    	// Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
    	// Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

    	// You can refer to workspaces by index. However, keep in mind that
    	// niri is a dynamic workspace system, so these commands are kind of
    	// "best effort". Trying to refer to a workspace index bigger than
    	// the current workspace count will instead refer to the bottommost
    	// (empty) workspace.
    	//
    	// For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
    	// will all refer to the 3rd workspace.
    	Mod+1 { focus-workspace 1; }
    	Mod+2 { focus-workspace 2; }
    	Mod+3 { focus-workspace 3; }
    	Mod+4 { focus-workspace 4; }
    	Mod+5 { focus-workspace 5; }
    	Mod+6 { focus-workspace 6; }
    	Mod+7 { focus-workspace 7; }
    	Mod+8 { focus-workspace 8; }
    	Mod+9 { focus-workspace 9; }
    	Mod+A { focus-workspace "steam"; }
    	Mod+Shift+1 { move-column-to-workspace 1; }
    	Mod+Shift+2 { move-column-to-workspace 2; }
    	Mod+Shift+3 { move-column-to-workspace 3; }
    	Mod+Shift+4 { move-column-to-workspace 4; }
    	Mod+Shift+5 { move-column-to-workspace 5; }
    	Mod+Shift+6 { move-column-to-workspace 6; }
    	Mod+Shift+7 { move-column-to-workspace 7; }
    	Mod+Shift+8 { move-column-to-workspace 8; }
    	Mod+Shift+9 { move-column-to-workspace 9; }
    	Mod+Shift+A { move-column-to-workspace "steam"; }

    	Mod+Ctrl+H  { consume-or-expel-window-left; }
    	Mod+Ctrl+L { consume-or-expel-window-right; }

    	Mod+Comma  { consume-window-into-column; }
    	Mod+Period { expel-window-from-column; }

    	Mod+F { maximize-column; }
    	Alt+F { fullscreen-window; }

    	Mod+Ctrl+F { expand-column-to-available-width; }

    	Mod+C { center-column; }

    	Mod+Ctrl+C { center-visible-columns; }

    	Mod+Minus { set-column-width "-10%"; }
    	Mod+Equal { set-column-width "+10%"; }

    	Mod+Shift+Minus { set-window-height "-10%"; }
    	Mod+Shift+Equal { set-window-height "+10%"; }

    	Super+Shift+S { toggle-window-floating; }
    	Super+S { switch-focus-between-floating-and-tiling; }

    	Mod+W { toggle-column-tabbed-display; }

    	Alt+Shift+S { screenshot; }
    	Ctrl+Print { screenshot-screen; }
    	Alt+Print { screenshot-window; }
    	
    	Mod+Shift+E { spawn "${pkgs.wleave}/bin/wleave"; }
    	Alt+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
    	Menu { spawn "${pkgs.equibop}/bin/equibop" "--toggle-deafen"; }
    	Ctrl+Menu { spawn "${pkgs.equibop}/bin/equibop" "--toggle-mic"; }

    }
  '';
in
{
  xdg.configFile."niri/config.kdl".text = lib.mkAfter bindsKdl;
}
