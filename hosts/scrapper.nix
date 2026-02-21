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
    passwordAuthentication = false;
  };

  host = {
    swapSize = 4 * 1024;
    mainUser = "space";
  };

  home-manager = {
    users."${config.host.mainUser}" = {
      dconf.enable = false;
      programs = {
        fish.enable = true;
        helix.enable = true;
        git.enable = true;
      };
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
}
