{ pkgs, config, ... }:

{
  networking.hostName = "puter";

  programs.desktopGroup.enable = true;

  virtualisation.libvirtd.enable = true;

  vr = {
    monado.enable = true;
    lighthouse.enable = true;
  };

  services.openssh.enable = true;

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
        hyprlock.lockImage = ../home/wallpapers/tri.png;
      };
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
}
