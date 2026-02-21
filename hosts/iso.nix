{ inputs, config, self, ... }:
{
  imports = [
    "${inputs.pkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  config = {
    networking.hostName = "iso";
    host.mainUser = "nixos";
    home-manager = {
      users."${config.host.mainUser}".programs = {
        helix.enable = true;
        fish.enable = true;
        fastfetch.enable = true;
        git.enable = true;
      };
    };
    services.openssh = {
      enable = true;
      autostart = true;
    };
    environment.etc."nixos-source".source = self;
  };
}
