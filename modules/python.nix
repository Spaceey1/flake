{ config, pkgs, lib, ... }:

{
	# All modules can extend this list
	options.my.python.packages = lib.mkOption {
		type = lib.types.listOf lib.types.package;
		default = [];
		description = "Python packages to include in the system python3";
	};

	config = {
		environment.systemPackages = [
			(pkgs.python3.withPackages (_: config.my.python.packages))
		];
	};
	config.systemd.tmpfiles.rules = [
		"L+ /usr/bin/python - - - - ${pkgs.python3}/bin/python3"
	];
}
