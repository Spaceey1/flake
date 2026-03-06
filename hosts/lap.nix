{ pkgs, config, ... }:

{
  programs.desktopGroup.enable = true;
  programs.niri.enable = true;

  hardware.bluetooth.enable = true;

  host = {
    gpuType = "intel";
    swapSize = 4 * 1024;
    isDesktopSystem = true;
    mainUser = "space";
    mainMonitor = "eDP-1";
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
        hyprlock.lockImage = ../home/wallpapers/tri.png;
      };
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
}
