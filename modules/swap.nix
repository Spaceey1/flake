{ lib, config, ... }:
{
  options = {
    host.swapSize = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Size of the swapfile, in megabytes";
    };
  };
  config = {
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = config.host.swapSize;
      }
    ];
  };
}
