{ config, pkgs, ... }:

{
	imports = [
		./wleave.nix
		./cursorThemes.nix
	];
	home.username = "space";
	home.homeDirectory = "/home/space";
	programs.home-manager.enable = true;
	home.stateVersion = "26.05";
}
