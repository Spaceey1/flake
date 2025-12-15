{ pkgs, config,hostName, lib, ... }:

let
mangoFiles = builtins.readDir ./mango/configs;

files =
builtins.concatStringsSep "\n"
(map
 (name: builtins.readFile (./mango/configs/${name}))
 (builtins.attrNames mangoFiles)
 );
in {
	options.programs.mango = {
		wallpaper = lib.mkOption {
			description = "path to wallpaper";
			type = lib.types.path;
		};
	};
	config = {
		xdg.configFile."mango/config.conf".text = ''
			exec-once=${pkgs.swaybg}/bin/swaybg -i ${config.programs.mango.wallpaper}
			exec-once=${pkgs.waybar}/bin/waybar
			exec-once=${pkgs.dunst}/bin/dunst
			exec-once=${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
			exec-once=XDG_CURRENT_DESKTOP=sway ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal -r & ${pkgs.xdg-desktop-portal-wlr}/libexec/xdg-desktop-portal-wlr
			${if (hostName == "puputer") then "
				bind=Alt, H,focusmon,HDMI-A-1
				bind=Alt, L,focusmon,HDMI-A-2
				bind=Alt+Shift, H,tagmon,HDMI-A-1,false
				bind=Alt+Shift, L,tagmon,HDMI-A-2,false
				"
				else ""}
			${files}
		'';
		xdg.configFile."xdg-desktop-portal".text =  ''
		[preferred]
		default=gtk
		org.freedesktop.impl.portal.Screenshot=wlr
		org.freedesktop.impl.portal.ScreenCast=wlr
		'';
	};
	imports = [ ./waybar.nix ];
}
