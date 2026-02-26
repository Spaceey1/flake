{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.host = {
    hasBattery = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the host is powered by a bettery";
    };
    mainUser = lib.mkOption {
      type = lib.types.str;
      description = "The primary user account";
    };
    gpuType = lib.mkOption {
      type = lib.types.str;
      description = "Type of gpu. Nvidia, AMD, etc.";
      default = "";
    };
  };
  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    users.users."${config.host.mainUser}" = {
      isNormalUser = true;
      shell = pkgs.fish;
      initialPassword = "123";
      extraGroups = [
        "wheel"
        "docker"
        "dialout"
      ];
    };

    boot = {
      consoleLogLevel = 3;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        systemd-boot.configurationLimit = 3;
        timeout = lib.mkOverride 60 0;
      };
      kernelParams = [
        "video=1920x1080"
        "quiet"
      ];
      plymouth = {
        enable = false;
        theme = "breeze";
        # themePackages = with pkgs; [
        #   kdePackages.breeze-plymouth
        # ];
      };
    };

    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Warsaw";
    nixpkgs.overlays = [
      (import ../overlays/local-packages.nix)
    ];

    ##Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "pl";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    programs.fish.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;
    environment.sessionVariables = {
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    };
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.05"; # don't change
  };
}
