{ pkgs, pkgsUnstable, ... }:

{
	programs.niri = {
		enable = true;
		package = pkgsUnstable.niri;
#useNautilus = false;
	};
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
