{ pkgs, config, ... }:

{
  networking.hostName = "puter";

  programs = {
    obs.enable = true;
    steam.enable = true;
    edhm.enable = true;
    niri.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  vr = {
    monado.enable = true;
    lighthouse.enable = true;
  };

  hardware.bluetooth.enable = true;

  host = {
    gpuType = "nvidia";
    swapSize = 8 * 1024;
    isDesktopSystem = true;
    mainUser = "space";
    mainMonitor = "HDMI-A-2";
    startupSession = "${pkgs.niri}/bin/niri-session";
  };

  home-manager = {
    users."${config.host.mainUser}" = {
      programs = {
        mango.wallpaper = ../home/wallpapers/tri.png;
        niri = {
          wallpaper = ../home/wallpapers/tri.png;
          animations = {
            enable = true;
            open = ../home/niri/shaders/open.frag;
            close = ../home/niri/shaders/close.frag;
          };
        };
        hyprlock = {
          enable = true;
          lockImage = ../home/wallpapers/tri.png;
          mainMonitor = config.host.mainMonitor;
        };
        helix.enable = true;
        kitty = {
          nemoOpen = true;
          enable = true;
        };
        rofi.enable = true;
        fish.enable = true;
        fastfetch.enable = true;
        waybar.enable = true;
        dunst.enable = true;
        git.enable = true;
      };
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
}
