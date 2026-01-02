{ config, lib, pkgs, ... }:

{
	options.host = {
		mainMonitor = lib.mkOption {
			type = lib.types.nullOr lib.types.str;
			default = null;
			description = "The primary monitor identifier for this host.";
		};
		hasBattery = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether the host is powered by a bettery";
		};
		mainUser = lib.mkOption {
			type = lib.types.str;
			description = "The primary user account";
		};
	};
	config = {
		nix.settings.experimental-features = [
			"nix-command"
			"flakes"
		];
		users.users."${config.host.mainUser}" = {
			isNormalUser = true;
			shell = pkgs.fish;
			extraGroups = [ "wheel" "docker" ];
		};
		nixpkgs.config.allowUnfree = true;


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
		environment.sessionVariables = {
			DOTNET_CLI_TELEMETRY_OPTOUT = "1";
		};
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
		system.stateVersion = "25.05"; # don't change
	};
}
