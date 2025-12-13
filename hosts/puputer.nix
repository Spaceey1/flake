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
		../modules/mango.nix
		../modules/steam.nix
		../modules/vr.nix
		../modules/waydroid.nix
		../modules/rgb.nix
		../modules/vsc.nix
		../modules/nvidia.nix
	];

	networking.hostName = "puputer";

	users.users = {
		"space" = {
			isNormalUser = true;
			shell = pkgs.fish;
			extraGroups = [ "wheel" ];
		};
		"sharky" = {
			isNormalUser = true;
			shell = pkgs.fish;
			extraGroups = [];
		};
	};
	home-manager.users.space = import ../home/space/space.nix;
	fileSystems."/home" = {
		device = "/dev/disk/by-uuid/087ffb5f-76b1-4429-882e-1d2b544bb895";
		fsType = "ext4";
	};

	fileSystems."/Stuffs" = {
		device = "/dev/disk/by-uuid/aa65865d-d79a-4328-b805-2ce6556e2f48";
		fsType = "ext4";
	};
}

