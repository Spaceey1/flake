{ pkgs, ... }:
{
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb-with-all-plugins;
    server.port = 6742;
  };
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];
}
