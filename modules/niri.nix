{ pkgs, pkgsUnstable, ... }:

{
	programs.niri = {
		enable = true;
		package = pkgsUnstable.niri;
	};
	environment.systemPackages = [ pkgs.xdg-desktop-portal-gnome ];
	systemd.user.services = {
		swaybgniri = {
			serviceConfig = {
				ExecStart = "${pkgs.swaybg}/bin/swaybg -i /home/space/wallpapers/see.png";
				Restart = "on-abnormal";
			};
			after = [ "niri.service" ];
			wantedBy = [ "niri.service" ];
		};
	};
}
