{ pkgs, config, ... }:

{
  imports = [
    ./hardware/puter.nix
    ../modules/base.nix
    ../modules/desktop.nix
    ../modules/niri.nix
    ../modules/steam.nix
    ../modules/vr.nix
    ../modules/waydroid.nix
    ../modules/rgb.nix
    ../modules/vsc.nix
    ../modules/nvidia.nix
    ../modules/docker.nix
    ../modules/vms.nix
  ];

  networking.hostName = "puter";
  host.mainUser = "space";
  users.users = {
    "sharky" = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ ];
    };
  };
  home-manager.users."${config.host.mainUser}" = import ../home/home.nix;
  host.mainMonitor = "HDMI-A-2";
  host.startupSession = "${pkgs.niri}/bin/niri-session";
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/087ffb5f-76b1-4429-882e-1d2b544bb895";
    fsType = "ext4";
  };
  fileSystems."/Stuffs" = {
    device = "/dev/disk/by-uuid/aa65865d-d79a-4328-b805-2ce6556e2f48";
    fsType = "ext4";
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 32 GB
    }
  ];
}
