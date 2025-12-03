{ pkgs, pkgsUnstable, ... }:


{
	imports = [
		./python.nix
	];
	services.displayManager.ly = {
		enable = true;
	};
	programs.niri.enable = true;
	systemd.user.services = {
		swaybg = {
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
		steam
		kitty
		swaybg
		eww
		pkgsUnstable.equibop
		wl-clipboard
		rofi
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
		btop
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
	];
	environment.sessionVariables = {
		XCURSOR_THEME = "phinger-cursors-light";
		XCURSOR_SIZE = "24";
	};
	xdg.icons.fallbackCursorThemes = [ "phinger-cursors-light" ];
	services.flatpak.enable = true;
}
