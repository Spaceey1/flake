{ pkgs, config, ... }:

{
  imports = [
    ./hardware/lap.nix
    ../modules/base.nix
    ../modules/desktop.nix
    ../modules/niri.nix
    ../modules/bluetooth.nix
    ../modules/home-manager.nix
  ];
  networking.hostName = "lap";
  host.mainUser = "space";
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.mesa ];
  };
  host.hasBattery = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # 8 GB
    }
  ];
}
