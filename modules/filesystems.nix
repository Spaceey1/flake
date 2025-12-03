{ config, lib, pkgs, ... }:

{
#FileSystems and """symlinks"""

	#fileSystems."/usr/bin" = {
	#	fsType = "none";
	#	device = "/run/current-system/sw/bin";
	#	options = [ "bind" ];
	#};

	#fileSystems."/bin" = {
	#	fsType = "none";
	#	device = "/run/current-system/sw/bin";
	#	options = [ "bind" ];
	#};
}
