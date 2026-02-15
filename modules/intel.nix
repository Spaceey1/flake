{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.host.gpuType == "intel") {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vulkan-loader
        mesa
        intel-media-driver
        vpl-gpu-rt
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
        mesa
        intel-media-driver
      ];
    };
    services.xserver.videoDrivers = [ "modesetting" ];
  };
}
