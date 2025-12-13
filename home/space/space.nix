{ config, pkgs, ... }:

{
	imports = [
		./wleave.nix
		./cursorThemes.nix
		./niri.nix
		./mango.nix
	];
	home.username = "space";
	home.homeDirectory = "/home/space";
	programs.home-manager.enable = true;
	home.stateVersion = "25.05";
}
