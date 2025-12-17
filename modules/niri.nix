{ pkgs, pkgsUnstable, ... }:

{
	programs.niri = {
		enable = true;
		package = pkgsUnstable.niri;
	};
	environment.systemPackages = [ pkgs.xdg-desktop-portal-gnome ];
}
