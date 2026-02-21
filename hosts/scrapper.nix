{ pkgs, config, ... }:

{
  networking.hostName = "scrapper";
  networking.domain = "scrapped.space";
  services.matrix-synapse.enable = true;
  security.acme = {
    acceptTerms = true;
  };
  hardware.bluetooth.enable = true;

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    autostart = true;
  };

  host = {
    swapSize = 4 * 1024;
    mainUser = "space";
  };

  home-manager = {
    users."${config.host.mainUser}" = {
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
}
