{ config, lib, ... }:

{
  config = lib.mkIf config.hardware.bluetooth.enable {
    hardware.bluetooth.powerOnBoot = false;
    services.blueman.enable = config.host.isDesktopSystem;
  };
}
