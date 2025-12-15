{ config, pkgs, ... }:

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
	];
	programs.mango.wallpaper = ./wallpapers/tri.png;


	home.username = "space";
	home.homeDirectory = "/home/space";
	programs.home-manager.enable = true;
	home.stateVersion = "25.05";
}
