{
  osConfig,
  pkgs,
  ...
}:

{
  imports = [
    ./wleave.nix
    ./cursorThemes.nix
    ./mango.nix
    ./niri.nix
    ./dunst.nix
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./rofi.nix
    ./fastfetch.nix
    ./hyprlock.nix
    ./gtk.nix
    ./helix.nix
    ./xdg.nix
  ];

  programs.mango.wallpaper = ./wallpapers/tri.png;
  programs.niri.wallpaper = ./wallpapers/tri.png;
  programs.hyprlock = {
    lockImage = ./wallpapers/tri.png;
    mainMonitor = osConfig.host.mainMonitor;
  };
  home.username = "${osConfig.host.mainUser}";
  home.homeDirectory = "/home/${osConfig.host.mainUser}";
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  home.packages =
    with pkgs;
    [
      teamspeak6-client
      wget
      librewolf
      kitty
      swaybg
      eww
      equibop
      wl-clipboard
      xwayland-satellite
      spotifywm
      playerctl
      fastfetch
      zoxide
      wleave
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
      mpv
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
      pinta
    ]
    ++ lib.optional osConfig.host.hasBattery powertop;
}
