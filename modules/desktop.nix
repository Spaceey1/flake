{ pkgs, pkgsUnstable, config, ... }:


{
	imports = [
		./python.nix
	];
	services.greetd = {
		enable = true;
		settings = rec {
			initial_session = {
				command = "${pkgs.niri}/bin/niri-session";
				user = "space";
			};
			default_session = initial_session;
		};
	};
	services.printing.enable = true;
	services.pipewire = {
			enable = true;
			pulse.enable = true;
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
		fastfetch
		zoxide
		pkgsUnstable.wleave
		pwvucontrol
		openrgb
		btop-cuda
		hyprlock
		nemo
		jq
		dunst
		libnotify
		obs-studio
		ffmpeg
		yt-dlp
		pkgsUnstable.mpv
		telegram-desktop
		feh
		blender
		qpwgraph
		unzip
		unrar
		openssh
		gparted
		qbittorrent
		qalculate-gtk
		baobab
		nil
		rofi-emoji
	] ++ lib.optional config.host.hasBattery powertop;

	security.polkit.enable = true;
	programs.nix-ld.enable = true;
	xdg.icons.fallbackCursorThemes = [ "phinger-cursors-light" ];
	xdg.portal.enable = true;
	services.locate.enable = true;
	services.locate.package = pkgs.plocate;
	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		PROTON_ENABLE_WAYLAND="1";
		ELECTRON_OZONE_PLATFORM_HINT="auto";
	};
}
