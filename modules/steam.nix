{ pkgs, config, ... }:

{
#Steam shit

	hardware.graphics = {
		enable = true;
		enable32Bit = true;  # Steam needs 32-bit
		extraPackages = with pkgs; [
			vulkan-loader
			mesa
		];
		extraPackages32 = with pkgs.pkgsi686Linux; [
			vulkan-loader
			mesa
		];
	};
	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
		modesetting.enable = true;
		open = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

	hardware.steam-hardware.enable = true;

	programs.steam.enable = true;
	programs.gamescope.enable = true;
}
