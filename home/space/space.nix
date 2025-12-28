{ config, pkgs, osConfig, ... }:

{
	imports = [
		./wleave.nix
		./cursorThemes.nix
		./mango.nix 
		./niri.nix
		./dunst.nix
		./fish.nix
		./git.nix
		./kitty.nix
		./rofi.nix
		./fastfetch.nix
		./hyprlock.nix
	];
	programs.mango.wallpaper = ./wallpapers/tri.png;
	programs.niri.wallpaper = ./wallpapers/tri.png;
	programs.hyprlock = {
		lockImage = ./wallpapers/tri.png;
		mainMonitor = osConfig.host.mainMonitor;
	};


	home.username = "space";
	home.homeDirectory = "/home/space";
	programs.home-manager.enable = true;
	home.stateVersion = "25.05";
}
