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
		./nvim.nix
	];

	programs.mango.wallpaper = ./wallpapers/tri.png;
	programs.niri.wallpaper = ./wallpapers/tri.png;
	programs.hyprlock = {
		lockImage = ./wallpapers/tri.png;
		mainMonitor = osConfig.host.mainMonitor;
	};

	home.username = "${osConfig.host.mainUser}";
	home.homeDirectory = "/home/${osConfig.host.mainUser}";
	programs.home-manager.enable = true;
	home.stateVersion = "25.05";
}
