{
  inputs,
  pkgs,
  config, ... }:

{
  networking.hostName = "scrapper";
  networking.domain = "scrapped.space";
  services.matrix-synapse.enable = true;
  security.acme = {
    acceptTerms = true;
  };
  hardware.bluetooth.enable = true;

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
        fish.enable = true;
        helix.enable = true;
        git.enable = true;
      };
      home.username = "${config.host.mainUser}";
      home.homeDirectory = "/home/${config.host.mainUser}";
    };
  };
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  services.minecraft-server = {
    enable = true;
    package = pkgs.minecraftServers.vanilla-1_20_1;
    eula = true;
    openFirewall = true; # Opens the port the server is running on (by default 25565 but in this case 43000)
    declarative = true;
    whitelist = {
      # This is a mapping of Minecraft usernames to to the players' UUIDs
      Space1_ = "8c89820c-a622-42f1-a6b4-b5bf58d7ee3b";
      G4chaZack = "0423b06f-16bf-465e-93ac-4577343e8bd2";
    };
    serverProperties = {
      server-port = 25565;
      difficulty = 3;
      gamemode = 1;
      max-players = 5;
      motd = "NixOS Minecraft server!";
      white-list = true;
      allow-cheats = true;
    };
    jvmOpts = "-Xms2048M -Xmx2048M";
  };
}
