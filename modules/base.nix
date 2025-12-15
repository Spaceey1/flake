{ config, lib, pkgs, ... }:

{
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];
	nixpkgs.config.allowUnfree = true;

	imports = [ ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 3;
	boot.kernelParams = [ "video=1920x1080" ];

	networking.networkmanager.enable = true;
	time.timeZone = "Europe/Warsaw";
	nixpkgs.overlays = [
		(import ../overlays/local-packages.nix)
	];

##Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "pl";
#   useXkbConfig = true; # use xkb.options in tty.
# };

#Enable CUPS to print documents.
	services.printing.enable = true;
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	programs.fish.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
	networking.firewall.enable = true;
	services.openssh.enable = true;
	systemd.services.sshd.wantedBy = lib.mkForce [ ];
	home-manager.extraSpecialArgs = {
		inherit (config.networking) hostName;
	};
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
	system.stateVersion = "25.05"; # don't change
	
}
