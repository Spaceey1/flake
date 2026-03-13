{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  networking.domain = "scrapped.space";
  services.matrix-synapse.enable = true;
  security.acme = {
    acceptTerms = true;
  };
  hardware.bluetooth.enable = true;

  theme.palette.primary = config.theme.makeColorAttrFromHex config.theme.baseColors.orange.hex;

  services.logind.settings = {
    Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    autostart = true;
    settings.PasswordAuthentication = false;
  };

  host = {
    swapSize = 4 * 1024;
    mainUser = "space";
  };

  home-manager = {
    users."${config.host.mainUser}" = {
      dconf.enable = false;
      programs = {
        fish = {
          enable = true;
        };
        helix.enable = true;
        git.enable = true;
        fastfetch.enable = true;
      };
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
}
