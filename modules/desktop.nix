{ pkgs, pkgsUnstable, ... }:


{
	imports = [
		./python.nix
	];
	services.displayManager.ly = {
		enable = true;
	};
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
	environment.systemPackages = with pkgs; [
		neovim
		wget
		librewolf
		kitty
		swaybg
		eww
		pkgsUnstable.equibop
		wl-clipboard
		pkgsUnstable.rofi
		xwayland-satellite
		spotifywm
		playerctl
		git
		fastfetch
		zoxide
		phinger-cursors
		pkgsUnstable.wleave
		pwvucontrol
		openrgb
		btop-cuda
		hyprlock
		nemo
		mint-themes
		jq
		dunst
		libnotify
		cargo
		obs-studio
		ffmpeg
		yt-dlp
		pkgsUnstable.mpv
		telegram-desktop
		feh
		blender
		qpwgraph
	];
	environment.sessionVariables = {
		XCURSOR_THEME = "phinger-cursors-light";
		XCURSOR_SIZE = "24";
	};
	xdg.icons.fallbackCursorThemes = [ "phinger-cursors-light" ];
	services.flatpak.enable = true;
	services.locate.enable = true;
	services.locate.package = pkgs.plocate;
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
