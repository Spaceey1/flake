{ pkgs,config, ... }:

{
	imports = [
		./lap-hardware.nix
		../modules/base.nix
		../modules/desktop.nix
		../modules/niri.nix
		../modules/mango.nix
	];
	networking.hostName = "lap";
	host.mainUser = "space";
	hardware.graphics = {
		enable = true;
		extraPackages = [ pkgs.mesa ];
	};
	home-manager.users."${config.host.mainUser}"= import ../home/home.nix;
	host.hasBattery = true;
	swapDevices = [{
		device = "/var/lib/swapfile";
		size = 8*1024; # 8 GB
	}];
}

