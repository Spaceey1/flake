{ pkgs, config, ... }:

{
  imports = [
    ./hardware/lap.nix
    ../modules/base.nix
    ../modules/desktop.nix
    ../modules/niri.nix
    ../modules/bluetooth.nix
    ../modules/home-manager.nix
    ../modules/steam.nix
  ];
  networking.hostName = "lap";
  host.mainMonitor = "eDP-1";
  host.mainUser = "space";
  host.startupSession = "${pkgs.niri}/bin/niri-session";
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      mesa
      intel-media-driver # For Broadwell (2014) and newer
      vpl-gpu-rt # For QuickSync video (encoding/decoding)
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
      mesa
      intel-media-driver # For Broadwell (2014) and newer
    ];
  };
  services.xserver.videoDrivers = [ "modesetting" ];
  host.hasBattery = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # 8 GB
    }
  ];
}
