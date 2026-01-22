{ pkgsUnstable, ... }:
{
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgsUnstable.openrgb-with-all-plugins;
    server.port = 6742;
  };
  environment.systemPackages = with pkgsUnstable; [
    openrgb-with-all-plugins
  ];
}
