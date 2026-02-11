{ pkgs, config, ... }:

{
  imports = [
    ./hardware/puter.nix
    ../modules/base.nix
    ../modules/desktop.nix
    ../modules/niri.nix
    ../modules/steam.nix
    ../modules/vr.nix
    ../modules/nvidia.nix
    ../modules/home-manager.nix
    ../modules/blender.nix
    ../modules/edhm.nix
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
      size = 8 * 1024; # 32 GB
    }
  ];
}
