{
  pkgs,
  config,
  lib,
  ...
}:
{
  config =
    lib.mkIf (config.host.gpuType == "nvidia") {

      hardware.graphics = {
        enable = true;
        enable32Bit = true; # Steam needs 32-bit
        extraPackages = with pkgs; [
          vulkan-loader
          mesa
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          vulkan-loader
          mesa
        ];
      };
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
}
