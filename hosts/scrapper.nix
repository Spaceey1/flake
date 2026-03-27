{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  networking.domain = "scrapped.space";
  networking.firewall = {
    allowedTCPPorts = [ 25565 ];
    allowedUDPPorts = [ 25565 ];
  };
  services.matrix-synapse.enable = true;
  systemd.tmpfiles.rules = [
    "d ${config.services.filebrowser.settings.root} 0750 filebrowser filebrowser -"
    "d /var/lib/public/users/Space/Overte 2755 filebrowser filebrowser -"
  ];
  services.filebrowser = {
    enable = true;
    settings = {
      port = 8080;
      address = "localhost";
      root = "/var/lib/public";
    };
    openFirewall = true;
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "files.${config.networking.domain}" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.filebrowser.settings.port}";
        };
        locations."/overte/" = {
          alias = "${config.services.filebrowser.settings.root}/users/Space/Overte/";
          extraConfig = "allow all;";
        };
        enableACME = true;
        forceSSL = true;
      };
    };
  };
  systemd.services.filebrowser.serviceConfig.UMask = lib.mkForce "0022";
  users.users.nginx.extraGroups = [ "filebrowser" ];

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
