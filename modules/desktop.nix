{ pkgs, pkgsUnstable, ... }:


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
		unzip
		unrar
		openssh
		gparted
		qbittorrent
		qalculate-gtk
	];
	security.polkit.enable = true;
	environment.sessionVariables = {
		XCURSOR_THEME = "phinger-cursors-light";
		XCURSOR_SIZE = "24";
		GTK_THEME = "Mint-Y-Dark-Teal";
	};
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		dotnetCorePackages.runtime_9_0-bin
	];

	xdg.icons.fallbackCursorThemes = [ "phinger-cursors-light" ];
	xdg.portal.enable = true;
	services.locate.enable = true;
	services.locate.package = pkgs.plocate;
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
