{ pkgs, config, ... }:

{
  networking.hostName = "lap";

  programs = {
    obs.enable = true;
  };

  hardware.bluetooth.enable = true;

  host = {
    gpuType = "intel";
    homeManager.enable = true;
    swapSize = 4 * 1024;
    isDesktopSystem = true;
    mainUser = "space";
    mainMonitor = "eDP-1";
    startupSession = "${pkgs.niri}/bin/niri-session";
  };
}
