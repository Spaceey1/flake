{ pkgs, config, ... }:

{
  networking.hostName = "puter";

  programs = {
    obs.enable = true;
    steam.enable = true;
  };

  vr = {
    monado.enable = true;
    lighthouse.enable = true;
  };

  hardware.bluetooth.enable = true;

  host = {
    gpuType = "nvidia";
    homeManager.enable = true;
    swapSize = 8 * 1024;
    isDesktopSystem = true;
    mainUser = "space";
    mainMonitor = "HDMI-A-2";
    startupSession = "${pkgs.niri}/bin/niri-session";
  };
}
