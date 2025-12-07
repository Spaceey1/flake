{ pkgsUnstable, ...}:
{
	services.hardware.openrgb = {
		enable = true;
		motherboard = "amd";
		package = pkgsUnstable.openrgb-with-all-plugins;
	};
	environment.systemPackages = with pkgsUnstable; [
		openrgb-with-all-plugins
	];
}
