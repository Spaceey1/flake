{ pkgs, config, lib, ... }:

let
niriFiles = builtins.readDir ./niri/configs;

files =
builtins.concatStringsSep "\n"
(map
 (name: builtins.readFile (./niri/configs/${name}))
 (builtins.attrNames niriFiles)
 );
in {
	imports = [ ./niri/animations.nix ];
	options.programs.niri = {
		wallpaper = lib.mkOption {
			description = "path to wallpaper";
			type = lib.types.path;
		};
	};
	config = {
		xdg.configFile."niri/config.kdl".text = ''
		spawn-at-startup "${pkgs.dunst}/bin/dunst"
		spawn-at-startup "${pkgs.waybar}/bin/waybar" "-c" "${config.home.homeDirectory}/.config/waybar/config-niri.jsonc"
		spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-i" "${config.programs.niri.wallpaper}"
		spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
		${files}'';
	};
}
