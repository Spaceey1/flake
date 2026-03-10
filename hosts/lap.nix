{ pkgs, config, ... }:

{
  programs.desktopGroup.enable = true;
  programs.niri.enable = true;

  hardware.bluetooth.enable = true;

theme.palette.primary = config.theme.makeColorAttrFromHex config.theme.baseColors.cyan.hex;

  host = {
    gpuType = "intel";
    swapSize = 4 * 1024;
    isDesktopSystem = true;
    mainUser = "space";
    mainMonitor = "eDP-1";
    startupSession = "${pkgs.niri}/bin/niri-session";
    hasBattery = true;
  };

  home-manager = {
    users."${config.host.mainUser}" = {
      programs = {
        niri = {
          wallpaper = ../home/wallpapers/for.png;
          animations = {
            enable = true;
            open = ../home/niri/shaders/open.frag;
            close = ../home/niri/shaders/close.frag;
          };
        };
        hyprlock.lockImage = ../home/wallpapers/for.png;
      };
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
}
