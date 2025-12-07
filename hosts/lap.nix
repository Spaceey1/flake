# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# List packages installed in system profile.
# You can use https://search.nixos.org/ to find more packages (and options).

{ pkgs, ... }:

{
	imports = [
		../hardware-configuration.nix
		../modules/base.nix
		../modules/desktop.nix
		../modules/steam.nix
	];

	networking.hostName = "lap";

	users.users = {
		"space" = {
			isNormalUser = true;
			shell = pkgs.fish;
			extraGroups = [ "wheel" ];
		};
	};
	home-manager.users.space = import ../home/space/space.nix;
}

